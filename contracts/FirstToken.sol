// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier OnlyOwner() {
        require(msg.sender == owner, "You are not the owner, You can do this");
        _;
    }
}

contract pausable is Ownable {
    bool public paused;

    modifier whenNotPaused() {
        require(!paused, "Token is paused");
        _;
    }

    function pause() public OnlyOwner {
        paused = true;
    }

    function unPause() public OnlyOwner {
        paused = false;
    }
}

contract Token is Ownable, pausable {
    mapping(address => uint256) public balances;

    function transfer(address to, uint256 amount) public whenNotPaused {
        require(balances[msg.sender] >= amount, "Insufficiant Balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function mint(address to, uint256 amount) public OnlyOwner {
        balances[to] += amount;
    }
}
