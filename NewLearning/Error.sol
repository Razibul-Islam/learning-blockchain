// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ErrorHandle{
    error insufficientBalance(uint256 requested, uint256 amount);

    address private owner;

    constructor(){
        owner = msg.sender;
    }



    mapping (address => uint256) private balances;
    modifier onlyOwner(){
        require(owner == msg.sender,"You are not the owner");
        _;
    }

    function withdraw(address account, uint amount) public returns(bool){
        require(balances[account] >= amount,"You can not withdraw");
        balances[account] -= amount;
        return true;
    }

    function transfer(address account, uint256 amount) public returns(bool){
        if(balances[account] <= amount){
            revert insufficientBalance(amount, balances[msg.sender]);
        }

        balances[account] += amount;
        balances[msg.sender] -= amount;
        return true;
    }

    function checkBalance(address account) public view returns(uint){
        assert(balances[account] > 0);
        return balances[account];
    }
}