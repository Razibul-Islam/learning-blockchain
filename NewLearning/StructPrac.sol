// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract structPrac{
    struct Student{
        string name;
        uint256 roll;
        uint256 grade;
    }

    Student[] private students;

    mapping (address => Student) private Students;

    function addStudent(address account, string calldata name, uint256 roll, uint256 grade) public returns(bool){
        Students[account] = Student(name,roll,grade);
        return true;
    }
}