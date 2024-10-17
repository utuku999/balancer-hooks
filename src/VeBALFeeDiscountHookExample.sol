// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {BaseHooks} from "@balancer-labs/v3-vault/contracts/BaseHooks.sol";
import {IVault} from "@balancer-labs/v3-interfaces/contracts/vault/IVault.sol";

/**
 * @title VeBAL Fee Discount Hook
 * @notice Applies a 50% discount to the swap fee for users that hold veBAL
 */
contract VeBALFeeDiscountHook is BaseHooks {
    constructor(IVault vault) BaseHooks(vault) {}
}
