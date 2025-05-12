// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract RewardToken is ERC20, Ownable{

    uint256 currentTime;

    constructor(address initialOwner) ERC20("RewardToken","RWT") Ownable(initialOwner){
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function mint(uint256 amount) public onlyOwner{
        require(amount <= 100,"Maximum mint amount is 100");
        _mint(msg.sender, amount);
    }

    function mintReward(address to,uint256 amount) public {
        require(currentTime + 60 <= block.timestamp,"wait 1 minute for each mint");
        require(amount * 10 ** decimals() <= 100 * 10 ** decimals(),"Maximum mint amount is 100");
        require(totalSupply()+amount <= 1000000  *10 ** decimals(),"Totalsupply exceed");

        _mint(to, amount);
        currentTime = block.timestamp;
    }

}