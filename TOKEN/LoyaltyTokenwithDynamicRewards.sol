// SPDX-License-Ientifier: MIT
pragma solidity ^0.8.28;

contract LoyaltyTokenwithDynamicRewards{
    string public name = "LoyalityToken";
    string public symbol = "LTK";
    uint256 public decimels = 18;
    uint256 public totalSupply;

    uint256 public constant rewardInterval = 1 weeks;
    uint256 public constant rewardAmount = 10 * 10**18;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowance;
    mapping(address => uint256) private lastTransferTimestamp;
    mapping(address => uint256) private pendingRewards;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approve(address indexed owner, address indexed spender, uint256 value);
    event RewardClaimed(address indexed user,uint256 amount);
    event Burn(address indexed burner, uint256 amount);

    modifier noZeroAddress(address addr){
        require(addr == address(0),"Zero Address is not Allowed");
        _;
    }

    constructor(){
        uint256 initialSupply = 1000 * 10 ** 18;
        balances[msg.sender] = initialSupply;
        totalSupply = initialSupply;
        lastTransferTimestamp[msg.sender] = block.timestamp;
        emit Transfer(address(0), msg.sender, initialSupply);
    }

    function transfer(address to, uint256 amount) external noZeroAddress(to) returns(bool){
        _updateReward(msg.sender);
        _updateReward(to);
        require(balances[msg.sender] >= amount, "not enough token");

        balances[msg.sender] -= amount;
        balances[to] += amount;

        lastTransferTimestamp[to] = block.timestamp;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external noZeroAddress(spender) returns(bool){
        allowance[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external noZeroAddress(from) returns(bool){
        _updateReward(from);
        _updateReward(to);

        require(balances[from] >= amount ,"Insufficient Balance");
        require(allowance[from][msg.sender] >= amount,"Allowance Exceeded");

        balances[from] -= amount;
        balances[to] += amount;
        allowance[from][msg.sender] -= amount;

        lastTransferTimestamp[to] = block.timestamp;
        emit Transfer(from,to,amount);
        return true;
    }

    function _updateReward(address user) internal{
        if(balances[user] > 0){
            uint256 heldTime = block.timestamp - lastTransferTimestamp[user];
            uint256 rewardUnits = heldTime / rewardInterval;

            if(rewardUnits > 0){
                uint256 reward = rewardUnits * rewardAmount;
                pendingRewards[user] += reward;
                lastTransferTimestamp[user] = block.timestamp;
            }
        }
    }

    function _claimRewards() external {
        _updateReward(msg.sender);

        uint256 reward = pendingRewards[msg.sender];
        require(reward > 0,"No rewards to claim");

        pendingRewards[msg.sender] = 0;
        balances[msg.sender] += reward;
        totalSupply += reward;

        emit RewardClaimed(msg.sender, reward);
        emit Transfer(address(0), msg.sender, reward);

    }

    function burn(uint256 amount) external{
        require(balances[msg.sender] >= amount,"Not enough token to burn");
        
        balances[msg.sender] -= amount;
        totalSupply -= amount;

        emit Burn(msg.sender, amount);
        emit Transfer(msg.sender, address(0), amount);
    }

}