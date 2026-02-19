// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract YieldVault is ERC20, Ownable, ReentrancyGuard {
    IERC20 public immutable asset;
    address public strategy;

    constructor(address _asset) 
        ERC20("Vault Shares", "vSHARES") 
        Ownable(msg.sender) 
    {
        asset = IERC20(_asset);
    }

    function setStrategy(address _strategy) external onlyOwner {
        strategy = _strategy;
    }

    function deposit(uint256 amount) external nonReentrant {
        uint256 shares = totalSupply() == 0 ? amount : (amount * totalSupply()) / totalAssets();
        asset.transferFrom(msg.sender, address(this), amount);
        _mint(msg.sender, shares);
        
        // Push funds to strategy
        asset.transfer(strategy, amount);
    }

    function withdraw(uint256 shares) external nonReentrant {
        uint256 amount = (shares * totalAssets()) / totalSupply();
        _burn(msg.sender, shares);
        
        // Logic to pull funds from strategy goes here
        asset.transfer(msg.sender, amount);
    }

    function totalAssets() public view returns (uint256) {
        return asset.balanceOf(address(this)) + asset.balanceOf(strategy);
    }
}
