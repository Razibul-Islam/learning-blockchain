// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract First{

    // Problem-2
    struct Book{
        string title;
        string author;
        uint price;
    }

    Book public book = Book("Mojai Moja","Razibul",100);


    // Problem 1
    string public name = "Razibul";
    uint256 public age = 22;
    bool public isMember = true;

    // problem - 3

    enum VoteStatus {NotVoted, Voted, Rejected }

    VoteStatus public vote = VoteStatus.Voted;

    // problem - 4
    int profit = 100;
    int loss = -50;

    function add() public view returns(int){
        return profit + loss;
    }

    // problem - 5
    address owner = msg.sender;

    function getAddress() public view returns(address) {
        return owner;
    }
}