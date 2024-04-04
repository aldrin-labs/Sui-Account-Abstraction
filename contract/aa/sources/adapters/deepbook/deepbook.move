// TODO: Add apdater for Custodian API
module aa::deepbook_clob_v2 {
    use sui::clock::Clock;
    use sui::tx_context::TxContext;

    use deepbook::clob_v2::{Self, Pool, MatchedOrderMetadata};
    use deepbook::custodian_v2::AccountCap;

    use aa::account::{Self, Account, XCoin, unwrap, wrap};

    // for smart routing
    public fun swap_exact_base_for_quote<BaseAsset, QuoteAsset>(
        pool: &mut Pool<BaseAsset, QuoteAsset>,
        client_order_id: u64,
        account_cap: &AccountCap,
        quantity: u64,
        base_coin: XCoin<BaseAsset>,
        quote_coin: XCoin<QuoteAsset>,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext,
    ): (XCoin<BaseAsset>, XCoin<QuoteAsset>, u64) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &base_coin);
        account::assert_origin(account, &quote_coin);

        let base_coin = unwrap(base_coin);
        let quote_coin = unwrap(quote_coin);

        let (coin_base, coin_quote, res) = clob_v2::swap_exact_base_for_quote(
            pool,
            client_order_id,
            account_cap,
            quantity,
            base_coin,
            quote_coin,
            clock,
            ctx,
        );

        (wrap(account, coin_base), wrap(account, coin_quote), res)
    }

    // for smart routing
    public fun swap_exact_base_for_quote_with_metadata<BaseAsset, QuoteAsset>(
        pool: &mut Pool<BaseAsset, QuoteAsset>,
        client_order_id: u64,
        account_cap: &AccountCap,
        quantity: u64,
        base_coin: XCoin<BaseAsset>,
        quote_coin: XCoin<QuoteAsset>,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext,
    ): (XCoin<BaseAsset>, XCoin<QuoteAsset>, u64, vector<MatchedOrderMetadata<BaseAsset, QuoteAsset>>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &base_coin);
        account::assert_origin(account, &quote_coin);

        let base_coin = unwrap(base_coin);
        let quote_coin = unwrap(quote_coin);

        let (base_coin, quote_coin, res, meta) = clob_v2::swap_exact_base_for_quote_with_metadata(
            pool,
            client_order_id,
            account_cap,
            quantity,
            base_coin,
            quote_coin,
            clock,
            ctx,
        );

        (wrap(account, base_coin), wrap(account, quote_coin), res, meta)
    }

    // for smart routing
    public fun swap_exact_quote_for_base<BaseAsset, QuoteAsset>(
        pool: &mut Pool<BaseAsset, QuoteAsset>,
        client_order_id: u64,
        account_cap: &AccountCap,
        quantity: u64,
        clock: &Clock,
        quote_coin: XCoin<QuoteAsset>,
        account: &mut Account,
        ctx: &mut TxContext,
    ): (XCoin<BaseAsset>, XCoin<QuoteAsset>, u64) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &quote_coin);

        let quote_coin = unwrap(quote_coin);

        let (base_coin, quote_coin, res) = clob_v2::swap_exact_quote_for_base(
            pool,
            client_order_id,
            account_cap,
            quantity,
            clock,
            quote_coin,
            ctx,
        );

        (wrap(account, base_coin), wrap(account, quote_coin), res)
    }

    public fun swap_exact_quote_for_base_with_metadata<BaseAsset, QuoteAsset>(
        pool: &mut Pool<BaseAsset, QuoteAsset>,
        client_order_id: u64,
        account_cap: &AccountCap,
        quantity: u64,
        clock: &Clock,
        quote_coin: XCoin<QuoteAsset>,
        account: &mut Account,
        ctx: &mut TxContext,
    ): (XCoin<BaseAsset>, XCoin<QuoteAsset>, u64, vector<MatchedOrderMetadata<BaseAsset, QuoteAsset>>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &quote_coin);

        let quote_coin = unwrap(quote_coin);

        let (base_coin, quote_coin, res, meta) = clob_v2::swap_exact_quote_for_base_with_metadata(
            pool,
            client_order_id,
            account_cap,
            quantity,
            clock,
            quote_coin,
            ctx,
        );

        (wrap(account, base_coin), wrap(account, quote_coin), res, meta)
    }

    /// Place a market order to the order book.
    public fun place_market_order<BaseAsset, QuoteAsset>(
        pool: &mut Pool<BaseAsset, QuoteAsset>,
        account_cap: &AccountCap,
        client_order_id: u64,
        quantity: u64,
        is_bid: bool,
        base_coin: XCoin<BaseAsset>,
        quote_coin: XCoin<QuoteAsset>,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext,
    ): (XCoin<BaseAsset>, XCoin<QuoteAsset>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &base_coin);
        account::assert_origin(account, &quote_coin);

        let base_coin = unwrap(base_coin);
        let quote_coin = unwrap(quote_coin);

        let (base_coin, quote_coin) = clob_v2::place_market_order(
            pool,
            account_cap,
            client_order_id,
            quantity,
            is_bid,
            base_coin,
            quote_coin,
            clock,
            ctx,
        );

        (wrap(account, base_coin), wrap(account, quote_coin))
    }

    public fun place_market_order_with_metadata<BaseAsset, QuoteAsset>(
        pool: &mut Pool<BaseAsset, QuoteAsset>,
        account_cap: &AccountCap,
        client_order_id: u64,
        quantity: u64,
        is_bid: bool,
        base_coin: XCoin<BaseAsset>,
        quote_coin: XCoin<QuoteAsset>,
        clock: &Clock,
        account: &mut Account,
        ctx: &mut TxContext,
    ): (XCoin<BaseAsset>, XCoin<QuoteAsset>, vector<MatchedOrderMetadata<BaseAsset, QuoteAsset>>) {
        account::assert_delegate(account, ctx);
        account::assert_origin(account, &base_coin);
        account::assert_origin(account, &quote_coin);

        let base_coin = unwrap(base_coin);
        let quote_coin = unwrap(quote_coin);

        let (base_coin, quote_coin, meta) = clob_v2::place_market_order_with_metadata(
            pool,
            account_cap,
            client_order_id,
            quantity,
            is_bid,
            base_coin,
            quote_coin,
            clock,
            ctx,
        );

        (wrap(account, base_coin), wrap(account, quote_coin), meta)
    }
}