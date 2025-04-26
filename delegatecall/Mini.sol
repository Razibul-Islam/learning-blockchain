// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract mini{



    
    function register(address target,string memory name,uint256 age) public {
        bytes memory data = abi.encodeWithSignature("register(string,uint256)", name,age);

        (bool success,) = target.call(data);
        require(success,"faild");
    }
}