// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Refundable{

    address private owner;

    constructor() payable {
        owner = msg.sender;
    }

    mapping (address => uint256) private donations;
    event Donated(uint amount,address spender);

    function donate() public payable {
        donations[msg.sender] += msg.value;
        emit Donated(msg.value,msg.sender);
    }

    function getDonation(address _addr)public view returns(uint256) {
        return donations[_addr];
    }

    function refund() public payable {
        uint amount = donations[msg.sender];
        if(amount > 0){
            donations[msg.sender] = 0;
            payable(msg.sender).transfer(amount);
        } else{
            revert("you did not donate anything");
        }
    }
}