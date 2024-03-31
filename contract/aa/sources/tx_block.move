// module aa::tx_block {
//     // use std::debug::print;
//     use std::option::{Option, Self, none, some, is_some, borrow};
//     use sui::object::{Self, UID, ID};
//     use sui::tx_context::{TxContext, sender};
//     use sui::balance::{Self, Balance};
//     use sui::clock::{Self, Clock};
//     use sui::transfer;
//     use sui::coin::{Coin, Self};
//     use sui::event;
//     use sui::sui::SUI;

//     use aa::move_call::{MoveCall, MoveCallReceipt};

//     struct TxBlock {
//         call_block: vector<MoveCall>,
//         called: vector<MoveCallReceipt>,
//     }


// }