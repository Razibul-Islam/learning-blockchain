// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IAccessControl {
    function addRole(address user, string memory role) external;

    function removeRole(address user) external;

    function getRole(address user) external view returns (string memory);
}

contract AccessControlManager is IAccessControl {
    address admin;
    mapping(address => bytes32) private roles;

    constructor() {
        admin = msg.sender;
        roles[admin] = keccak256(abi.encodePacked("Admin"));
    }


    modifier checkAdminOrManager() {
        require(
            admin == msg.sender ||
                roles[msg.sender] ==
                keccak256(abi.encodePacked("Manager")),
            "You are not Admin Or Manager"
        );
        _;
    }

    modifier checkAdmin() {
        require(admin == msg.sender, "You are not Admin");
        _;
    }

    event RoleAdding(address indexed user, string role, string action);

    function addRole(address user, string memory role)
        external
        override
        checkAdminOrManager
    {
        roles[user] = keccak256(abi.encodePacked(role));
        emit RoleAdding(user, role, "User Add");
    }

    function removeRole(address user) external override checkAdmin {
        delete roles[user];
    }

    function getRole(address user)
        external
        view
        override
        returns (string memory)
    {
        if(roles[user] == keccak256(abi.encodePacked("Admin"))) return "Admin";
        if(roles[user] == keccak256(abi.encodePacked("Manager"))) return "Manager";
        return "";
    }
}


contract Admin{
    IAccessControl public ac;

    constructor(address user){
        ac = IAccessControl(user);
    }

    function addMember(address user, string memory role) external {
        ac.addRole(user, role);
    }

    function removeMember(address user) external {
        ac.removeRole(user);
    }

    function viewRole(address user) external view returns(string memory) {
        return ac.getRole(user);
    }

}