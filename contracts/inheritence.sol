// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Animal {
    string public AnimalType;

    function changeType(string memory newType) public virtual {
        AnimalType = newType;
    }
}

contract Dog is Animal {
    constructor() {
        AnimalType = "Kutta";
    }

    function changeType(string memory newType) public override {
        AnimalType = newType;
    }
}
