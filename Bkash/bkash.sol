// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBkash {
    function diposit(address to, uint amount) external pure returns(bool) ;
    function withdrow(address to, uint amount) external pure returns(bool);
    function getBalance(address add) external pure returns(uint);
}

contract wallet{
    function userWallet()
}