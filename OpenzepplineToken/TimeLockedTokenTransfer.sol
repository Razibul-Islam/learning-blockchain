// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TimeLockedTokenTransfer is ERC20, Ownable {
    uint256 public constant INITIAL_SUPPLY = 1000000 * 10 ** 18;
    uint256 public constant LOCK_DURATION = 1 hours;

    mapping(address => uint256) public lastReceived;

    event LockedTransfer(
        address indexed from,
        address indexed to,
        uint256 amount,
        string reason
    );

    constructor(
        address initalAddress
    ) ERC20("TimeLockToken", "TLT") Ownable(initalAddress) {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override {
        if (from != owner()) {
            require(
                block.timestamp >= lastReceived[from] + LOCK_DURATION,
                "Transfer Locked: wait 1 hour"
            );
            lastReceived[to] = block.timestamp;
        }
        super._update(from, to, amount);

        lastReceived[to] = block.timestamp;
    }

    function getUnlockTime(address user) external view returns (uint256) {
        return lastReceived[user] + LOCK_DURATION;
    }
}
