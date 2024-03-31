// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

module referral_vault::referral_vault {
	struct ReferralVault has key {
		id: sui::object::UID,
		version: u64,
		referrer_addresses: sui::table::Table<address, address>,
		rebates: sui::table::Table<address, sui::bag::Bag>
	}

	fun init(
		_arg_0: &mut sui::tx_context::TxContext
	)
	{
		abort 0
	}

	public fun has_referrer(
		_arg_0: &referral_vault::referral_vault::ReferralVault,
		_arg_1: address
	): bool
	{
		abort 0
	}

	public fun referrer_for(
		_arg_0: &referral_vault::referral_vault::ReferralVault,
		_arg_1: address
	): std::option::Option<address>
	{
		abort 0
	}

	public fun referrer_has_rebate(
		_arg_0: &referral_vault::referral_vault::ReferralVault,
		_arg_1: address
	): bool
	{
		abort 0
	}

	public fun referrer_has_rebate_with_type<T0>(
		_arg_0: &referral_vault::referral_vault::ReferralVault,
		_arg_1: address
	): bool
	{
		abort 0
	}

	public fun balance_of<T0>(
		_arg_0: &referral_vault::referral_vault::ReferralVault,
		_arg_1: address
	): u64
	{
		abort 0
	}

	public fun update_referrer_address(
		_arg_0: &mut referral_vault::referral_vault::ReferralVault,
		_arg_1: address,
		_arg_2: &sui::tx_context::TxContext
	)
	{
		abort 0
	}

	public fun deposit_rebate<T0>(
		_arg_0: &mut referral_vault::referral_vault::ReferralVault,
		_arg_1: sui::coin::Coin<T0>,
		_arg_2: address,
		_arg_3: &mut sui::tx_context::TxContext
	)
	{
		abort 0
	}

	public fun withdraw_rebate<T0>(
		_arg_0: &mut referral_vault::referral_vault::ReferralVault,
		_arg_1: &mut sui::tx_context::TxContext
	): sui::coin::Coin<T0>
	{
		abort 0
	}

	public fun withdraw_and_transfer<T0>(
		_arg_0: &mut referral_vault::referral_vault::ReferralVault,
		_arg_1: &mut sui::tx_context::TxContext
	)
	{
		abort 0
	}

	public fun assert_version(
		_arg_0: &referral_vault::referral_vault::ReferralVault
	)
	{
		abort 0
	}
}