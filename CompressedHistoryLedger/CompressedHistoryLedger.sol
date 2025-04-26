// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract CompressedHistoryLedger{
    struct fileRecord{
        string fileHash;
        uint256 timeStamp;
        bool isActive;
    }

    mapping (address => fileRecord[]) private userFile;
    mapping (address => mapping (string => bool)) private hashUploaded;

    event fileUploaded(address indexed user, string fileHash, uint256 timestamp);
    event fileDeleted(address indexed user, string fileHash);

    modifier uniqueFile(string calldata filehash){
        require(!hashUploaded[msg.sender][filehash],"This file already uploaded");
        _;
    }

    modifier maxFileLimite(){
        require(userFile[msg.sender].length < 100,"You have reached your file upload limited");
        _;
    }


    function fileUpload(string calldata fileHash) external uniqueFile(fileHash) maxFileLimite{
        fileRecord memory newFile = fileRecord(fileHash,block.timestamp,true);

        userFile[msg.sender].push(newFile);
        hashUploaded[msg.sender][fileHash] = true;
        
        emit fileUploaded(msg.sender, fileHash, block.timestamp);
    }

    function deleteFile(string calldata fileHash) external {
        fileRecord[] storage files = userFile[msg.sender];
        for(uint256 i = 0; i < files.length; i++){
            if(keccak256(bytes(files[i].fileHash)) == keccak256(bytes(fileHash)) && files[i].isActive){
                files[i].isActive = false;
                emit fileDeleted(msg.sender, fileHash);
                return;
            }
        }
        revert("File is already deleted or not found");
    }

    function getActiveFile(address user) external view returns(string[] memory){
        fileRecord[] storage files = userFile[user];

        uint256 count = 0;

        for(uint256 i = 0; i < files.length; i++){
            if(files[i].isActive){
                count++;
            }
        }

        string[] memory activeFiles = new string[](count);
        uint index = 0;
        for(uint i = 0; i< files.length; i++){
            if(files[i].isActive){
                activeFiles[index] = files[i].fileHash;
                index++;
            }
        }

        return activeFiles;
    }
}