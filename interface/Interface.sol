// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Interface declear for Token
interface IToken {
    // Declear Function without emplementation
    function getBalance(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function mint(address to, uint256 amount) external;
}

contract MyToken is IToken {
    mapping(address => uint256) private balance;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function getBalance(address account) external view override returns(uint256){
        return balance[account];
    }

    function transfer(address to, uint256 amount) external override returns(bool){
        require(balance[msg.sender] >= amount,"Insufficient Balance");

        balance[msg.sender] -= amount;
        balance[to] += amount;

        return true;
    }

    function mint(address to, uint256 amount) external override {
        require(msg.sender == owner,"Only owner can mint Token");
        balance[to] += amount;
    }
}

contract TokenUser{
    IToken public token;

    constructor(address TokenAddress){
        token = IToken(TokenAddress);
    }

    function checkMyBalance() external view returns(uint256){
        return token.getBalance(msg.sender);
    }

    function transferToken(address to,uint256 amount) external {
        require(token.transfer(to, amount),"Transfer faild");
    }
}


// Token Exchange

contract TokenExchange{
    IToken public token1;
    IToken public token2;

    uint public rate;

    constructor(address _token1, address _token2, uint _rate){
        token1 = IToken(_token1);
        token2 = IToken(_token2);
        rate = _rate;
    }

    function SwapToken(uint amount) external {
        require(token1.getBalance(msg.sender) >= amount,"Insufficient Balance");
        uint token2Amount = amount * rate;

        require(token1.transfer(address(this), amount),"Transfer Faild");

        require(token2.transfer(msg.sender, token2Amount),"Transfer Faild");
    }
}