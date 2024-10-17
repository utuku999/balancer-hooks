// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import {BaseHooks} from "@balancer-labs/v3-vault/contracts/BaseHooks.sol";

/**
 * @title VeBAL Fee Discount Hook
 * @notice Applies a 50% discount to the swap fee for users that hold veBAL
 */
contract VeBALFeeDiscountHook is BaseHooks {
    constructor(IVault vault) BaseHooks(vault) {}
}
