// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract AccessControl {
    enum Role {
        None,
        User,
        Admin
    }

    address private owner;

    mapping(address => Role) private roles;

    modifier onlyAdmin() {
        require(
            roles[msg.sender] == Role.Admin,
            "You are not the admin, only admin can do this."
        );
        _;
    }

    modifier onlyUser() {
        require(roles[msg.sender] == Role.User, "Only User can do this");
        _;
    }

    modifier onlyOwer() {
        require(msg.sender == owner, "You are not the owner of this contract");
        _;
    }

    constructor() {
        owner = msg.sender;
        roles[msg.sender] = Role.Admin;
    }

    function setRole(address _address, Role _role) public onlyAdmin {
        roles[_address] = _role;
    }

    function AdminCheck() public view onlyAdmin returns (string memory) {
        return "Only Admin";
    }

    function OwnerCheck() public view onlyOwer returns (string memory) {
        return "This is only owner";
    }

    function userCheck() public view onlyUser returns (string memory) {
        return "This is for Users";
    }

    function everyOne() public pure returns (string memory) {
        return "This is for everyOne";
    }

    function checkStatus(address _add) public view returns (Role) {
        return roles[_add];
    }
}
