// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract YieldStrategy is Ownable {
    address public vault;
    address public activeProtocol;

    constructor(address _vault) Ownable(msg.sender) {
        vault = _vault;
    }

    modifier onlyVault() {
        require(msg.sender == vault, "Only vault");
        _;
    }

    function rebalance(address newProtocol) external onlyOwner {
        // 1. Withdraw from activeProtocol
        // 2. Swap rewards for underlying asset
        // 3. Deposit into newProtocol
        activeProtocol = newProtocol;
    }

    function emergencyWithdraw() external onlyOwner {
        // Safety mechanism to pull all funds back to vault
    }
}
