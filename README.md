# Reputation System

This Solidity smart contract manages a **reputation system** using **World ID**. Users can rate service providers from **1 to 5 stars**, and the contract stores and calculates the average rating.

## Features
- Users can rate providers (1-5 stars).
- Stores all ratings linked to a **World ID**.
- Returns the **average rating** per user.

## Smart Contract

```solidity
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
        return user.ratingCount == 0 ? 0 : user.totalScore / user.ratingCount;
    }
}
```

# Usage

### ✅ Rate a User
```solidity
rateUser(bytes32 worldId, uint8 score)
```
- `worldId`: Unique user identifier (`bytes32`).
- `score`: Rating between `1-5`.

### 📊 Get User's Average Score
```solidity
getAverageScore(bytes32 worldId) -> uint256
```
- Returns the **average rating**.

## Example

### Rate a provider
```js
const worldId = "0x6c9b7d...a7b8c";
await contract.rateUser(worldId, 5);
```

### Get average rating
```js
const avgScore = await contract.getAverageScore(worldId);
console.log("Average Rating:", avgScore.toString());
```

## License
MIT License.

