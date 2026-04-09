// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IAggregator.sol";

/**
 * @title DexAggregator
 * @dev Aggregates liquidity from multiple routers for optimal swaps.
 */
contract DexAggregator is Ownable {
    
    constructor() Ownable(msg.sender) {}

    /**
     * @dev Simple split-swap between two routers.
     */
    function splitSwap(
        address _router1,
        address _router2,
        uint256 _amount1,
        uint256 _amount2,
        address[] calldata _path,
        uint256 _minTotalOut
    ) external {
        IERC20(_path[0]).transferFrom(msg.sender, address(this), _amount1 + _amount2);
        IERC20(_path[0]).approve(_router1, _amount1);
        IERC20(_path[0]).approve(_router2, _amount2);

        uint256 balanceBefore = IERC20(_path[_path.length - 1]).balanceOf(msg.sender);

        IDexRouter(_router1).swapExactTokensForTokens(_amount1, 0, _path, msg.sender, block.timestamp);
        IDexRouter(_router2).swapExactTokensForTokens(_amount2, 0, _path, msg.sender, block.timestamp);

        uint256 balanceAfter = IERC20(_path[_path.length - 1]).balanceOf(msg.sender);
        require(balanceAfter - balanceBefore >= _minTotalOut, "High slippage");
    }
}
