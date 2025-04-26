// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CharityFund {
    mapping(address => uint) public donations;

    function donate() public payable {
        donations[msg.sender] += msg.value;
    }

    function withdrawDonation() public {
        require(donations[msg.sender] > 0, "Nothing to withdraw");

        donations[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: donations[msg.sender]}("");
        require(success, "Transfer failed");

    }
}
