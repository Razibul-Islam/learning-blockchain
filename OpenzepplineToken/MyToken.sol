// SPDX-License-Identifire: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

contract MyToken is ERC20, Ownable,Pausable {
    constructor(
        address initialOwnerShip
    ) ERC20("MyToken", "MTK") Ownable(initialOwnerShip) {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function pauseToken() public onlyOwner {
        _pause();
    }

    function unPausedToken() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from,address to,uint256 amount) internal whenNotPaused {
        _beforeTokenTransfer(from,to,amount);
    }

}
