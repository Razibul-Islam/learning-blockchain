// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GalaxyToken{
    string public name;
    string public symbol;
    uint8 public decimels;
    uint256 public totalSupply;
    address public owner;
    bool public pause;

    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) private allowance;

    modifier onlyOwner(){
        require(msg.sender == owner,"You are not the owner");
        _;
    }

    modifier whenNotPoused(){
        require(!pause,"Transfer are paused");
        _;
    }

    constructor(string memory _name,string memory _symbol,uint8 _decimels){
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        decimels = _decimels;
        _mint(msg.sender, 1000000 * 10 ** decimels);
    }

    function _mint(address _addr, uint256 amount) internal {
        require(_addr != address(0),"Invalid Address");
        balances[_addr] += amount;
        totalSupply += amount;
    }

    function burn(uint256 amount) public {
        require(balances[msg.sender] >= amount,"Not Enough Token");
        balances[msg.sender] -= amount;
        totalSupply -= amount;
    }

    function paused() public onlyOwner{
        pause = true;
    }

    function unPaused() public onlyOwner{
        pause = false;
    }

    function transfer(address _to, uint256 amount) public whenNotPoused returns(bool){
        require(_to != address(0),"Invalid Address");
        require(balances[msg.sender] >= amount,"Insufficient Balance");
        require(amount <= totalSupply / 50,"Anti whale: Max 2% per transfer");

        uint256 fee = (amount * 2) / 100;
        uint256 amountAfterFee = amount - fee;

        balances[msg.sender] -= amount;
        balances[_to] += amountAfterFee;
        balances[owner] += fee;

        return true;
    }

    function approve(address _spender,uint _amount)public returns(bool){
        allowance[msg.sender][_spender] = _amount;
        return true;
    }

    function transferFrom(address from,address to, uint256 amount) public whenNotPoused returns(bool){
        require(to != address(0),"Invalid Address");
        require(balances[from] >= amount,"Insufficient Balance");
        require(allowance[from][to] >= amount,"Allowance Exceeded");
        require(amount <= totalSupply / 50,"Anti-Whale: Max 2% per Transfer");

        uint fee = (amount*2)/ 100;
        uint amountAfterFee = amount - fee;

        balances[from] -= amount;
        allowance[from][msg.sender] += amount;

        balances[to] += amountAfterFee;
        balances[owner] += fee;
        
        return true;
    }

}