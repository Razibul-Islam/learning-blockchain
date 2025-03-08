// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPaymentGetway {
    function pay(address recipient, uint256 amount) external;

    function refund(address recipient, uint256 amount) external;
}

contract simplePayment is IPaymentGetway {
    address owner;
    mapping(address => uint256) private balances;

    constructor() {
        owner = msg.sender;
    }

    modifier checkOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier checkBalance(address recipient, uint256 amount) {
        require(balances[recipient] >= amount, "Influence Balance");
        _;
    }

    event successPayment(address recipient, uint256 amount);

    function pay(address recipient, uint256 amount)
        external
        override
        checkOwner
    {
        balances[recipient] += amount;
        emit successPayment(recipient, amount);
    }

    function refund(address recipient, uint256 amount)
        external
        override
        checkBalance(recipient, amount)
        checkOwner
    {
        balances[recipient] -= amount;
    }
}
