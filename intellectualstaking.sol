// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract IntellectualStaking {
    IERC20 public token;
    struct Research {
        address author;
        uint256 stakeAmount;
        bool approved;
    }

    mapping(bytes32 => Research) public researchSubmissions;

    event ResearchSubmitted(bytes32 indexed researchId, address indexed author, uint256 stake);
    event ResearchReviewed(bytes32 indexed researchId, bool approved);

    constructor(address _token) {
        token = IERC20(_token);
    }

    function submitResearch(bytes32 researchId, uint256 stake) external {
        require(researchSubmissions[researchId].author == address(0), "Already submitted");
        
        token.transferFrom(msg.sender, address(this), stake);
        researchSubmissions[researchId] = Research(msg.sender, stake, false);

        emit ResearchSubmitted(researchId, msg.sender, stake);
    }

    function reviewResearch(bytes32 researchId, bool approved) external {
        require(researchSubmissions[researchId].author != address(0), "Invalid research ID");

        researchSubmissions[researchId].approved = approved;
        emit ResearchReviewed(researchId, approved);
    }
}