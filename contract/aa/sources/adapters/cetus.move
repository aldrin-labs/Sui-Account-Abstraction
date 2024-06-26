module aa::cetus_router {
    use cetus_clmm::config::GlobalConfig;
    use cetus_clmm::pool::Pool;
    use cetus::router;
    use sui::clock::Clock;
    use sui::coin::Coin;
    use sui::tx_context::TxContext;

    use aa::account::{Self, Account, XCoin, unwrap, wrap, inner};

    public fun swap_ab<A, B>(
        config: &GlobalConfig,
        pool: &mut Pool<A, B>,
        input_funds: XCoin<A>,
        output_funds: XCoin<B>,
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
        // two constant of sqrt price(x64 fixed-point number). When a2b equals true,
        // it equals 4295048016, when a2b equals false, it equals 79226673515401279992447579055.
        sqrt_price_limit: u128,
        arg_8: bool,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext
    ): (XCoin<A>, XCoin<B>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &input_funds);
        account::assert_origin(account, &output_funds);

        let input_funds = unwrap(input_funds);
        let output_funds = unwrap(output_funds);

        let (coin_a, coin_b) = router::swap(
            config,
            pool,
            input_funds,
            output_funds,
            a2b,
            by_amount_in,
            amount,
            sqrt_price_limit,
            arg_8,
            clock,
            ctx
        );

        (wrap(account, coin_a), wrap(account, coin_b))
    }
    
    public fun swap_ba<A, B>(
        config: &GlobalConfig,
        pool: &mut Pool<A, B>,
        input_funds: XCoin<B>,
        output_funds: XCoin<A>,
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
        // two constant of sqrt price(x64 fixed-point number). When a2b equals true,
        // it equals 4295048016, when a2b equals false, it equals 79226673515401279992447579055.
        sqrt_price_limit: u128,
        arg_8: bool,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext
    ): (XCoin<A>, XCoin<B>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &input_funds);
        account::assert_origin(account, &output_funds);

        let input_funds = unwrap(input_funds);
        let output_funds = unwrap(output_funds);
        
        let (coin_a, coin_b) = router::swap(
            config,
            pool,
            output_funds,
            input_funds,
            a2b,
            by_amount_in,
            amount,
            sqrt_price_limit,
            arg_8,
            clock,
            ctx
        );

        (wrap(account, coin_a), wrap(account, coin_b))
    }

    public fun swap_ab_bc<A, B, C>(
        config: &GlobalConfig,
        pool_i: &mut Pool<A, B>,
        pool_ii: &mut Pool<B, C>,
        input_funds: XCoin<A>,
        output_funds: XCoin<C>,
        by_amount_in: bool,
        amount_0: u64,
        amount_1: u64,
        sqrt_price_limit_0: u128,
        sqrt_price_limit_1: u128,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext
    ): (XCoin<A>, XCoin<C>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &input_funds);
        account::assert_origin(account, &output_funds);

        let input_funds = unwrap(input_funds);
        let output_funds = unwrap(output_funds);

        let (coin_a, coin_c) = router::swap_ab_bc(
            config,
            pool_i,
            pool_ii,
            input_funds,
            output_funds,
            by_amount_in,
            amount_0,
            amount_1,
            sqrt_price_limit_0,
            sqrt_price_limit_1,
            clock,
            ctx
        );

        (wrap(account, coin_a), wrap(account, coin_c))
    }

    public fun swap_ab_cb<A, B, C>(
        config: &GlobalConfig,
        pool_i: &mut Pool<A,B>,
        pool_ii: &mut Pool<C,B>,
        input_funds: XCoin<A>,
        output_funds: Coin<C>,
        by_amount_in: bool,
        amount_0: u64,
        amount_1: u64,
        sqrt_price_limit_0: u128,
        sqrt_price_limit_1: u128,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext
    ): (XCoin<A>, XCoin<C>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &input_funds);
        let input_funds = unwrap(input_funds);

        let (coin_a, coin_c) = router::swap_ab_cb(
            config,
            pool_i,
            pool_ii,
            input_funds,
            output_funds,
            by_amount_in,
            amount_0,
            amount_1,
            sqrt_price_limit_0,
            sqrt_price_limit_1,
            clock,
            ctx
        );

        (wrap(account, coin_a), wrap(account, coin_c))
    }

    public fun swap_ba_bc<A, B, C>(
        config: &GlobalConfig,
        pool_i: &mut Pool<B, A>,
        pool_ii: &mut Pool<B, C>,
        input_funds: XCoin<A>,
        output_funds: XCoin<C>,
        by_amount_in: bool,
        amount_0: u64,
        amount_1: u64,
        sqrt_price_limit_0: u128,
        sqrt_price_limit_1: u128,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext
    ): (XCoin<A>, XCoin<C>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &input_funds);
        account::assert_origin(account, &output_funds);

        let input_funds = unwrap(input_funds);
        let output_funds = unwrap(output_funds);

        let (coin_a, coin_c) = router::swap_ba_bc(
            config,
            pool_i,
            pool_ii,
            input_funds,
            output_funds,
            by_amount_in,
            amount_0,
            amount_1,
            sqrt_price_limit_0,
            sqrt_price_limit_1,
            clock,
            ctx
        );

        (wrap(account, coin_a), wrap(account, coin_c))
    }

    public fun swap_ba_cb<A, B, C>(
        config: &GlobalConfig,
        pool_i: &mut Pool<B, A>,
        pool_ii: &mut Pool<C,B>,
        input_funds: XCoin<A>,
        output_funds: XCoin<C>,
        by_amount_in: bool,
        amount_0: u64,
        amount_1: u64,
        sqrt_price_limit_0: u128,
        sqrt_price_limit_1: u128,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext
    ): (XCoin<A>, XCoin<C>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &input_funds);
        account::assert_origin(account, &output_funds);
        
        let input_funds = unwrap(input_funds);
        let output_funds = unwrap(output_funds);

        let (coin_a, coin_c) = router::swap_ba_cb(
            config,
            pool_i,
            pool_ii,
            input_funds,
            output_funds,
            by_amount_in,
            amount_0,
            amount_1,
            sqrt_price_limit_0,
            sqrt_price_limit_1,
            clock,
            ctx
        );

        (wrap(account, coin_a), wrap(account, coin_c))
    }

    public fun calculate_router_swap_result<Ty0, Ty1, Ty2, Ty3>(
        pool_1: &mut Pool<Ty0, Ty1>,
        pool_2: &mut Pool<Ty2, Ty3>,
        a2b: bool,
        b2c: bool,
        by_amount_in: bool,
        amount: u64
    ) {
        router::calculate_router_swap_result(
            pool_1,
            pool_2,
            a2b,
            b2c,
            by_amount_in,
            amount
        )
    }

    public fun check_coin_threshold<Output>(arg_0: &XCoin<Output>, arg_1: u64) {
        router::check_coin_threshold(inner(arg_0), arg_1)
    }
}