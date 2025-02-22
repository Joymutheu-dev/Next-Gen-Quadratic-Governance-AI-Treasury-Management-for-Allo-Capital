// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ReputationManager {
    mapping(address => uint256) public reputationScores;
    mapping(address => uint256) public lastActivity;

    event ReputationUpdated(address indexed user, uint256 newScore);

    function updateReputation(address user, uint256 contributionScore) external {
        uint256 decay = block.timestamp - lastActivity[user] > 30 days ? 10 : 0;
        reputationScores[user] = reputationScores[user] + contributionScore - decay;

        lastActivity[user] = block.timestamp;
        emit ReputationUpdated(user, reputationScores[user]);
    }

    function getReputation(address user) external view returns (uint256) {
        return reputationScores[user];
    }
}