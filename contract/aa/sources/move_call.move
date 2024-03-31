// module aa::move_call {
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
//     use sui::object_bag::ObjectBag;
//     use sui::bag::Bag;
//     use sui::table_vec::TableVec;

//     struct CallProof has store {
//         mod: address,
//         function: address,
//         params: Bag,
//         result: Bag,
//     }

//     struct MoveCallDfKey has store, copy, drop { idx: u64 }

//     struct TxBlock {
//         call_length: u64,
//     }
    
//     struct MoveCall {
//         mod: address,
//         function: address,
//         params: ObjectBag,
//         result: ObjectBag,
//     }
    
//     struct MoveCallReceipt {
//         mod: address,
//         function: address,
//         // Params: Some dynamic fields
//         result: ObjectBag,
//     }
    
//     public(friend) fun new_proof<Wit>(
//         _witness: Wit,
//         call_proof: CallProof<Wit>,
//         result: Option<ObjectBag>
//     ): MoveCallReceipt {
//         MoveCallReceipt {
//         }
//     }

//     public(friend) fun new_receipt<Wit>(
//         call_proof: CallProof<Wit>,
//         function: string,
//         // params...
//     ): MoveCallReceipt {
//         MoveCallReceipt {

//         }
//     }
// }