// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AccessControlledBank {
    enum Role {
        Admin,
        User
    }

    mapping(address => Role) private roles;
    mapping(address => uint256) private balances;
    mapping(address => bool) private alreadyAcc;

    error insufficientBalance(uint256 amount, string message);

    constructor() {
        roles[msg.sender] = Role.Admin;
    }

    modifier onlyAdmin() {
        require(roles[msg.sender] == Role.Admin, "Only Admin can do This Task");
        _;
    }

    function createAccount(uint256 amount) public returns (bool) {
        require(!alreadyAcc[msg.sender], "You have already a account");
        require(amount > 0, "Amount must be greater then 0");
        balances[msg.sender] = amount;
        roles[msg.sender] = Role.User;
        alreadyAcc[msg.sender] = true;
        return true;
    }

    function Deposit(address _account, uint256 amount)
        public
        onlyAdmin
        returns (bool)
    {
        require(amount > 0, "Deposit amount should be more then 0");
        require(alreadyAcc[_account], "First create an account");

        balances[_account] += amount;

        return true;
    }

    function withdraw(uint256 amount) public returns (bool) {
        if (balances[msg.sender] > amount) {
            balances[msg.sender] -= amount;
            return true;
        }
        revert insufficientBalance(amount, "insufficient Balance");
    }

    function getBal() public view returns(uint256){
        return balances[msg.sender];
    }
}
