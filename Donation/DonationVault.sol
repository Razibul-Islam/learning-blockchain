// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract DonationVault{
    address private owner;

    constructor(){
        owner = msg.sender;
    }

    mapping(address => uint256) private values;

    function donate() public payable {
        values[msg.sender] += msg.value;
    }

    function getDonation(address _addr) public view returns(uint256){
        return values[_addr];
    }

    function withdraw() public{
        require(msg.sender == owner,"You are not the owner");
        payable(owner).transfer(address(this).balance);
        
    }
}