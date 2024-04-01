module aa::account {
    // use std::debug::print;
    use sui::object::{Self, UID, ID};
    use sui::tx_context::{TxContext, sender};
    use sui::balance::{Self, Balance};
    use sui::transfer;
    use sui::coin::{Coin, Self};
    use sui::dynamic_field as df;
    use sui::sui::SUI;

    const EUnauthorizedAccess: u64 = 0;
    const EZeroBalance: u64 = 1;
    const EBalanceUnavailable: u64 = 2;
    const EOriginMismatch: u64 = 3;

    friend aa::cetus_router;
    friend aa::flowx_router;

    struct BalanceDfKey<phantom FT> has copy, store, drop {}
    
    struct Account has key, store {
        id: UID,
        owner: address,
        delegate: address,
        sui_balance: Balance<SUI>,
        restricted: bool,
        dfs: UID,
    }

    struct AccountCap has key {
        id: UID,
        account_id: ID,
    }

    struct XCoin<phantom FT> {
        origin: ID,
        coin: Coin<FT>
    }

    // struct CoinPromise<phantom FT> {
    //     account_id: ID,
    //     amount: u64,
    // }

    // TODO: new() signed by delegate
    public fun new(delegate: address, ctx: &mut TxContext) {
        let sender = sender(ctx);

        let account_uid = object::new(ctx);
        let account_id = object::uid_to_inner(&account_uid);
        
        let account = Account {
            id: account_uid,
            owner: sender,
            delegate,
            sui_balance: balance::zero(),
            restricted: false,
            dfs: object::new(ctx),
        };

        let account_cap = AccountCap {
            id: object::new(ctx),
            account_id,
        };

        transfer::transfer(account_cap, sender);
        transfer::share_object(account);
    }

    public fun new_as_delegate(owner: address, ctx: &mut TxContext) {
        let sender = sender(ctx);

        let account_uid = object::new(ctx);
        let account_id = object::uid_to_inner(&account_uid);
        
        let account = Account {
            id: account_uid,
            owner,
            delegate: sender,
            sui_balance: balance::zero(),
            restricted: false,
            dfs: object::new(ctx),
        };

        let account_cap = AccountCap {
            id: object::new(ctx),
            account_id,
        };

        transfer::transfer(account_cap, owner);
        transfer::share_object(account);
    }

    public fun deposit<FT>(account: &mut Account, coin: Coin<FT>) {
        let balance_exists = df::exists_(dfs(account), BalanceDfKey<FT> {});

        if (!balance_exists) {
            df::add(dfs_mut(account), BalanceDfKey<FT> {}, balance::zero<FT>());
        };

        let balance: &mut Balance<FT> = df::borrow_mut(dfs_mut(account), BalanceDfKey<FT> {});
        balance::join(balance, coin::into_balance(coin));
    }

    public fun withdraw_with_promise<FT>(account: &mut Account, amount: u64, ctx: &mut TxContext): (XCoin<FT>) {
        assert_delegate(account, ctx);
        
        let balance_exists = df::exists_(dfs(account), BalanceDfKey<FT> {});
        assert!(balance_exists, EZeroBalance);

        let balance: &mut Balance<FT> = df::borrow_mut(dfs_mut(account), BalanceDfKey<FT> {});
        assert!(balance::value(balance) >= amount, EBalanceUnavailable);

        let coin = coin::from_balance(balance::split(balance, amount), ctx);

        wrap(account, coin)
    }

    public fun inner<FT>(x_coin: &XCoin<FT>): &Coin<FT> {
        &x_coin.coin
    }
    
    public(friend) fun wrap<FT>(account: &Account, coin: Coin<FT>): XCoin<FT> {
        XCoin { origin: object::uid_to_inner(&account.id), coin }
    }
    
    public(friend) fun unwrap<FT>(x_coin: XCoin<FT>): Coin<FT> {
        let XCoin { origin: _, coin } = x_coin;
        coin
    }
    
    public(friend) fun assert_origin<FT>(account: &Account, x_coin: &XCoin<FT>) {
        assert!(object::uid_to_inner(&account.id) == x_coin.origin, EOriginMismatch)
    }

    public fun assert_delegate(account: &Account, ctx: &TxContext) {
        assert!(sender(ctx) == account.delegate, EUnauthorizedAccess);
    }

    fun dfs(account: &Account): &UID {
        &account.dfs
    }
    
    fun dfs_mut(account: &mut Account): &mut UID {
        &mut account.dfs
    }

    fun unused(): bool { false }
    fun used(): bool { true }
}