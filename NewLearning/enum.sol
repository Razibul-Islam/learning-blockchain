// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Voting{
    enum Status {NotStarted, ongoing, Ended}
    struct Candidate{
        string name;
        uint256 voteCount;
    }

    Status public status;

    mapping (address => Candidate) private candidates;
    mapping (address => bool) private hasVoted;
    mapping(string => bool) private sameName;

    function setStatus(uint8 _status) public {
        status = Status(_status);
    }

    modifier Ongoing(){
        require(status == Status.ongoing,"You have to Start Voting");
        _;
    }

    modifier End(){
        require(status != Status.Ended,"Already Ended");
        _;
    }

    function addCandidate(address _add, string memory name) public Ongoing End returns(bool){
        require(!sameName[name],"name should be different");
        require(bytes(candidates[_add].name).length == 0,"Candidate can't add with the same Address");
        
        candidates[_add] = Candidate(name,0);
        sameName[name] = true;

        return true;
    }

    function Votestart(address _add) public Ongoing End returns(bool){
        require(!hasVoted[msg.sender],"Already Voted");

        candidates[_add].voteCount++;
        hasVoted[msg.sender] = true;

        return true;
    }

    function voteCountForCan(address _add) public view End returns(uint256){
        return candidates[_add].voteCount;
    }

}
