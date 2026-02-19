# Yield Aggregator Vault

This repository contains a high-quality "Strategy-based" yield optimizer. It allows users to deposit stablecoins into a single vault, which then programmatically moves the capital to whichever integrated lending protocol offers the highest real-time interest rate.

## How it Works
1. **Deposit:** Users deposit USDC/DAI and receive Vault Shares.
2. **Strategy:** The `rebalance()` function checks interest rates across Aave and Compound.
3. **Execution:** Funds are withdrawn from the lower-yield protocol and supplied to the higher-yield one.
4. **Harvest:** Accrued governance tokens (like COMP or AAVE) are sold for more underlying assets and reinvested, compounding the yield.



## Key Features
* **Auto-Compounding:** Automated selling of reward tokens to increase principal.
* **Gas Efficiency:** Batching transactions to reduce the cost of moving capital.
* **Security:** Integrated price oracles and slippage protection for swaps.

## Setup
1. Update protocol addresses in `Strategy.sol`.
2. Deploy the `Vault.sol` contract.
3. Call `setStrategy()` to link the logic to the capital.
