module aa::account {
    // use std::debug::print;
    use sui::object::{Self, UID, ID};
    use sui::tx_context::{TxContext, sender};
    use sui::balance::{Self, Balance};
    use sui::transfer;
    use sui::coin::{Coin, Self};
    use sui::dynamic_field as df;

    const EUnauthorizedAccess: u64 = 0;
    const EZeroBalance: u64 = 1;
    const EBalanceUnavailable: u64 = 2;
    const EPromiseAlreadyExists: u64 = 3;

    friend aa::cetus_router;

    struct BalanceDfKey<phantom FT> has copy, store, drop {}
    struct PromiseDfKey<phantom FT> has copy, store, drop { amount: u64 }
    
    struct Account has key, store {
        id: UID,
        owner: address,
        delegate: address,
        restricted: bool,
        dfs: UID,
    }

    struct AccountCap has key {
        id: UID,
        account_id: ID,
    }

    struct CoinPromise<phantom FT> {
        account_id: ID,
        amount: u64,
    }

    public fun new(delegate: address, ctx: &mut TxContext) {
        let sender = sender(ctx);

        let account_uid = object::new(ctx);
        let account_id = object::uid_to_inner(&account_uid);
        
        let account = Account {
            id: account_uid,
            owner: sender,
            delegate,
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

    public fun deposit<FT>(account: &mut Account, coin: Coin<FT>) {
        let balance_exists = df::exists_(dfs(account), BalanceDfKey<FT> {});

        if (!balance_exists) {
            df::add(dfs_mut(account), BalanceDfKey<FT> {}, balance::zero<FT>());
        };

        let balance: &mut Balance<FT> = df::borrow_mut(dfs_mut(account), BalanceDfKey<FT> {});
        balance::join(balance, coin::into_balance(coin));
    }

    public fun withdraw_with_promise<FT>(account: &mut Account, amount: u64, ctx: &mut TxContext): (Coin<FT>, CoinPromise<FT>) {
        assert_delegate(account, ctx);
        
        let balance_exists = df::exists_(dfs(account), BalanceDfKey<FT> {});
        assert!(balance_exists, EZeroBalance);

        let balance: &mut Balance<FT> = df::borrow_mut(dfs_mut(account), BalanceDfKey<FT> {});
        assert!(balance::value(balance) >= amount, EBalanceUnavailable);

        let coin = coin::from_balance(balance::split(balance, amount), ctx);

        let promise = request_promise<FT>(account, amount);

        (coin, promise)
    }

    public(friend) fun use_promise<FT>(account: &mut Account, coin: &Coin<FT>) {
        let amount = coin::value(coin);
        
        let state: &mut bool = df::borrow_mut(dfs_mut(account), PromiseDfKey<FT> { amount });
        *state = used();
    }

    fun request_promise<FT>(account: &mut Account, amount: u64): CoinPromise<FT> {
        let has_promise = df::exists_(dfs(account), PromiseDfKey<FT> { amount });

        assert!(!has_promise, EPromiseAlreadyExists);

        df::add(
            dfs_mut(account), PromiseDfKey<FT> { amount }, unused()
        );

        CoinPromise<FT> {
            account_id: object::uid_to_inner(&account.id),
            amount,
        }
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