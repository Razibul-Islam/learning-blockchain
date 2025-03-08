// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICalculator {
    function add(uint256 a, uint256 b) external pure returns (uint256);

    function multiply(uint256 a, uint256 b) external pure returns (uint256);
}

contract SimpleCalculator is ICalculator {
    function add(uint256 a, uint256 b) external pure override returns (uint256) {
        return a + b;
    }

    function multiply(uint256 a, uint256 b) external pure override returns (uint256) {
        return a * b;
    }
}

contract Calculator {
    ICalculator public cal;

    constructor(address add) {
        cal = ICalculator(add);
    }

    function getSum(uint256 firstNum, uint256 secondNum)
        external
        view
        returns (uint256)
    {
        return cal.add(firstNum, secondNum);
    }

    function getMul(uint256 firstNum, uint256 secondNum)
        external 
        view
        returns (uint256)
    {
        return cal.multiply(firstNum, secondNum);
    }
}
