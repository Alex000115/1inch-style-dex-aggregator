# DEX Aggregator (1inch-style)

A professional-grade implementation for high-efficiency DeFi trading. This repository solves the "Liquidity Fragmentation" problem. Instead of a user manually checking which DEX has the best price for a token, this aggregator programmatically splits an order across multiple venues. This ensures the lowest possible price impact and optimal routing for large-volume trades.

## Core Features
* **Smart Order Routing (SOR):** Logic to determine the most gas-efficient and price-optimized path across different DEXs.
* **Partial Fills:** Ability to execute parts of a single trade on different protocols simultaneously.
* **Slippage Protection:** Integrated checks to revert the transaction if the final price deviates beyond a user-defined threshold.
* **Flat Architecture:** Single-directory layout for the Aggregator Core, Protocol Adapters, and Fee Logic.



## Logic Flow
1. **Quote:** User requests to swap 1,000 ETH for USDC.
2. **Scan:** The aggregator checks prices on Uniswap V3, SushiSwap, and Balancer.
3. **Optimize:** It determines that swapping 60% on Uniswap and 40% on SushiSwap provides the best return.
4. **Execute:** The contract calls the respective DEX routers and delivers the USDC to the user in one transaction.

## Setup
1. `npm install`
2. Deploy `DexAggregator.sol` with the addresses of major DEX routers.
