// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ReentrancyVulnerable {
    mapping(address => uint256) public balances;

    // Deposit Ether
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Vulnerable withdraw
    function withdraw() public {
        uint amount = balances[msg.sender];
        require(amount > 0, "No balance");
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // Get contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
