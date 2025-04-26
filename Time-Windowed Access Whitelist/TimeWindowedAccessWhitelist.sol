// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TimeWindowedAccessWhitelist{
    struct TimeWindow{
        uint256 strat;
        uint256 end;
        bool isActive;
    }

    mapping (address => TimeWindow[]) private whiteLishWindow;

    modifier OnlyDuringWhiteLishedTime(){

    }

    event TimeWindowAdded(address indexed user,uint start, uint end);
    event ActionPersoform(address indexed user, uint timestamp);
}