// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReputationSystem {
    struct UserReputation {
        uint256 totalScore;
        uint256 ratingCount;
    }

    mapping(bytes32 => UserReputation) private reputations; 

    event Rated(bytes32 indexed worldId, uint8 score);

    function rateUser(bytes32 worldId, uint8 score) external {
        require(score >= 1 && score <= 5, "Score must be between 1 and 5");

        reputations[worldId].totalScore += score;
        reputations[worldId].ratingCount += 1;

        emit Rated(worldId, score);
    }

    function getAverageScore(bytes32 worldId) external view returns (uint256) {
        UserReputation memory user = reputations[worldId];

        if (user.ratingCount == 0) {
            return 0; 
        }

        return user.totalScore / user.ratingCount;
    }
}
