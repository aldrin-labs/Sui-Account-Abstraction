module aa::turbos_swap_router {
    use sui::tx_context::{TxContext};
    use turbos_clmm::swap_router;
    use turbos_clmm::pool::{Pool, Versioned};
    use sui::clock::Clock;
    use aa::account::{Self, Account, XCoin, unwrap};

    public fun swap_a_b<CoinTypeA, CoinTypeB, FeeType>(
		pool: &mut Pool<CoinTypeA, CoinTypeB, FeeType>,
        coin_a: XCoin<CoinTypeA>,
		// Exact input amount
        amount: u64,
        amount_threshold: u64,
        sqrt_price_limit: u128,
        is_exact_in: bool,
        recipient: address,
        deadline: u64,
        clock: &Clock,
        versioned: &Versioned,
        account: &mut Account,
		ctx: &mut TxContext
    ) {
        account::assert_delegate(account, ctx);
		account::assert_origin(account, &coin_a);
        assert!(recipient == account::receiver(account), 0);

        let coin_a = unwrap(coin_a);

        swap_router::swap_a_b(
            pool,
            vector[coin_a],
            amount,
            amount_threshold,
            sqrt_price_limit,
            is_exact_in,
            recipient,
            deadline,
            clock,
            versioned,
            ctx,
        );
    }

    public fun swap_b_a<CoinTypeA, CoinTypeB, FeeType>(
		pool: &mut Pool<CoinTypeA, CoinTypeB, FeeType>,
        coin_b: XCoin<CoinTypeB>,
		// Exact input amount
        amount: u64,
        amount_threshold: u64,
        sqrt_price_limit: u128,
        is_exact_in: bool,
        recipient: address,
        deadline: u64,
        clock: &Clock,
        versioned: &Versioned,
        account: &mut Account,
		ctx: &mut TxContext
    ) {
        account::assert_delegate(account, ctx);
		account::assert_origin(account, &coin_b);
        assert!(recipient == account::receiver(account), 0);

        let coin_b = unwrap(coin_b);

        swap_router::swap_b_a(
            pool,
            vector[coin_b],
            amount,
            amount_threshold,
            sqrt_price_limit,
            is_exact_in,
            recipient,
            deadline,
            clock,
            versioned,
            ctx,
        );
    }

    public fun swap_a_b_b_c<CoinTypeA, FeeTypeA, CoinTypeB, FeeTypeB, CoinTypeC>(
		pool_a: &mut Pool<CoinTypeA, CoinTypeB, FeeTypeA>,
        pool_b: &mut Pool<CoinTypeB, CoinTypeC, FeeTypeB>,
        coin_a: XCoin<CoinTypeA>,
		// Exact input amount
        amount: u64,
        amount_threshold: u64,
        sqrt_price_limit_one: u128,
        sqrt_price_limit_two: u128,
        is_exact_in: bool,
        recipient: address,
        deadline: u64,
        clock: &Clock,
        versioned: &Versioned,
        account: &mut Account,
		ctx: &mut TxContext
    ) {
        account::assert_delegate(account, ctx);
		account::assert_origin(account, &coin_a);
        assert!(recipient == account::receiver(account), 0);

        let coin_a = unwrap(coin_a);

        swap_router::swap_a_b_b_c(
            pool_a,
            pool_b,
            vector[coin_a],
            amount,
            amount_threshold,
            sqrt_price_limit_one,
            sqrt_price_limit_two,
            is_exact_in,
            recipient,
            deadline,
            clock,
            versioned,
            ctx,
        );
    }

    public fun swap_a_b_c_b<CoinTypeA, FeeTypeA, CoinTypeB, FeeTypeB, CoinTypeC>(
		pool_a: &mut Pool<CoinTypeA, CoinTypeB, FeeTypeA>,
        pool_b: &mut Pool<CoinTypeC, CoinTypeB, FeeTypeB>,
        coin_a: XCoin<CoinTypeA>,
		// Exact input amount
        amount: u64,
        amount_threshold: u64,
        sqrt_price_limit_one: u128,
        sqrt_price_limit_two: u128,
        is_exact_in: bool,
        recipient: address,
        deadline: u64,
        clock: &Clock,
        versioned: &Versioned,
        account: &mut Account,
		ctx: &mut TxContext
    ) {
        account::assert_delegate(account, ctx);
		account::assert_origin(account, &coin_a);
        assert!(recipient == account::receiver(account), 0);

        let coin_a = unwrap(coin_a);

        swap_router::swap_a_b_c_b(
            pool_a,
            pool_b,
            vector[coin_a],
            amount,
            amount_threshold,
            sqrt_price_limit_one,
            sqrt_price_limit_two,
            is_exact_in,
            recipient,
            deadline,
            clock,
            versioned,
            ctx,
        );
    }

    public fun swap_b_a_b_c<CoinTypeA, FeeTypeA, CoinTypeB, FeeTypeB, CoinTypeC>(
		pool_a: &mut Pool<CoinTypeB, CoinTypeA, FeeTypeA>,
        pool_b: &mut Pool<CoinTypeB, CoinTypeC, FeeTypeB>,
        coin_a: XCoin<CoinTypeA>,
		// Exact input amount
        amount: u64,
        amount_threshold: u64,
        sqrt_price_limit_one: u128,
        sqrt_price_limit_two: u128,
        is_exact_in: bool,
        recipient: address,
        deadline: u64,
        clock: &Clock,
        versioned: &Versioned,
        account: &mut Account,
		ctx: &mut TxContext
    ) {
        account::assert_delegate(account, ctx);
		account::assert_origin(account, &coin_a);
        assert!(recipient == account::receiver(account), 0);

        let coin_a = unwrap(coin_a);

        swap_router::swap_b_a_b_c(
            pool_a,
            pool_b,
            vector[coin_a],
            amount,
            amount_threshold,
            sqrt_price_limit_one,
            sqrt_price_limit_two,
            is_exact_in,
            recipient,
            deadline,
            clock,
            versioned,
            ctx,
        );
    }

    public fun swap_b_a_c_b<CoinTypeA, FeeTypeA, CoinTypeB, FeeTypeB, CoinTypeC>(
		pool_a: &mut Pool<CoinTypeB, CoinTypeA, FeeTypeA>,
        pool_b: &mut Pool<CoinTypeC, CoinTypeB, FeeTypeB>,
        coin_a: XCoin<CoinTypeA>,
		// Exact input amount
        amount: u64,
        amount_threshold: u64,
        sqrt_price_limit_one: u128,
        sqrt_price_limit_two: u128,
        is_exact_in: bool,
        recipient: address,
        deadline: u64,
        clock: &Clock,
        versioned: &Versioned,
        account: &mut Account,
		ctx: &mut TxContext
    ) {
        account::assert_delegate(account, ctx);
		account::assert_origin(account, &coin_a);
        assert!(recipient == account::receiver(account), 0);

        let coin_a = unwrap(coin_a);
        
        swap_router::swap_b_a_c_b(
            pool_a,
            pool_b,
            vector[coin_a],
            amount,
            amount_threshold,
            sqrt_price_limit_one,
            sqrt_price_limit_two,
            is_exact_in,
            recipient,
            deadline,
            clock,
            versioned,
            ctx,
        );
    }
}