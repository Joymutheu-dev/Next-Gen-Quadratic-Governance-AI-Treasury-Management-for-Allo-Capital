// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AIAllocator {
    address public owner;
    mapping(address => uint256) public allocatedFunds;

    event FundsAllocated(address indexed recipient, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function allocateFunds(address recipient, uint256 amount) external onlyOwner {
        allocatedFunds[recipient] += amount;
        emit FundsAllocated(recipient, amount);
    }

    function getAllocatedFunds(address recipient) external view returns (uint256) {
        return allocatedFunds[recipient];
    }
}