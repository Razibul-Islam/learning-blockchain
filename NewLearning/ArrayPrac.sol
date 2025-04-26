// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ArrayPrac {
    string[5] public movies = ["A", "B", "C", "D", "E"];

    struct Stud{
        string name;
        uint256 age;
    }

    uint256[] nums;

    Stud[] public students;

    function getAvarage() public returns (uint256) {
        uint256 sumOfNums;
        for (uint256 i = 0; i > 0; i++) {
            nums[i] += sumOfNums;
        }

        return sumOfNums;
    }

    function removeElem(uint8 index) public returns (bool) {
        for (uint256 i = index; i < movies.length - 1; i++) {
            movies[i] = movies[i+1];
        }
        return true;
    }

    function addStud(string memory name,uint256 age)public {
        students.push(Stud(name, age));
    }
}
