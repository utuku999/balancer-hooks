// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {BaseHooks} from "@balancer-labs/v3-vault/contracts/BaseHooks.sol";
import {IVault} from "@balancer-labs/v3-interfaces/contracts/vault/IVault.sol";
import {TokenConfig, LiquidityManagement, PoolSwapParams, HookFlags} from "@balancer-labs/v3-interfaces/contracts/vault/VaultTypes.sol";
import {IBasePoolFactory} from "@balancer-labs/v3-interfaces/contracts/vault/IBasePoolFactory.sol";
import {IRouterCommon} from "@balancer-labs/v3-interfaces/contracts/vault/IRouterCommon.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {VaultGuard} from "@balancer-labs/v3-vault/contracts/VaultGuard.sol";

/**
 * @title VeBAL Fee Discount Hook
 * @notice Applies a 50% discount to the swap fee for users that hold veBAL
 */
contract VeBALFeeDiscountHook is BaseHooks, VaultGuard {
    address private immutable _allowedFactory;
    address private immutable _trustedRouter;
    address private immutable _veBAL;

    constructor(
        IVault vault,
        address allowedFactory,
        address trustedRouter,
        address veBAL
    ) VaultGuard(vault) {
        _allowedFactory = allowedFactory;
        _trustedRouter = trustedRouter;
        _veBAL = veBAL;
    }

    // Return true to allow pool registration or false to revert
    function onRegister(
        address factory,
        address pool,
        TokenConfig[] memory,
        LiquidityManagement calldata
    ) public view override returns (bool) {
        // Only pools deployed by an allowed factory may use this hook
        return
            factory == _allowedFactory &&
            IBasePoolFactory(factory).isPoolFromFactory(pool);
    }

    // Return HookFlags struct that indicates which hooks this contract supports
    function getHookFlags()
        public
        pure
        override
        returns (HookFlags memory hookFlags)
    {
        // Support the 'onComputeDynamicSwapFeePercentage' hook
        hookFlags.shouldCallComputeDynamicSwapFee = true;
    }

    function onComputeDynamicSwapFeePercentage(
        PoolSwapParams calldata params,
        address /*pool*/,
        uint256 staticSwapFeePercentage
    )
        public
        view
        override
        onlyVault
        returns (bool success, uint256 dynamicSwapFeePercentage)
    {
        // If the router is not trusted, do not apply a fee discount
        if (params.router != _trustedRouter) {
            return (true, staticSwapFeePercentage);
        }

        // If the user owns veBAL, apply a 50% discount to the swap fee
        address user = IRouterCommon(params.router).getSender();

        if (IERC20(_veBAL).balanceOf(user) > 0) {
            return (true, staticSwapFeePercentage / 2);
        }

        // If the user holds zero veBAL, no discount
        return (true, staticSwapFeePercentage);
    }
}
