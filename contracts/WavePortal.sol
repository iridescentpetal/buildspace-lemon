// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    uint256 totalWaves;
    Wave[] waves;
    mapping (address => Wave[]) private _waveBalance;
    mapping (address => uint256) private _lastWaved;

    uint256 private randomSeed;

    constructor() payable {
        console.log("I am smart contract // WavePortal ~~~~");
        randomSeed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        ++totalWaves;
        console.log("%s waved w/ message %s", msg.sender, _message);

        require(
            _lastWaved[msg.sender] + 15 minutes < block.timestamp,
            "Please wait 15 minutes, you've waved too many times :("
        );

        waves.push(Wave(msg.sender, _message, block.timestamp));
        _lastWaved[msg.sender] = block.timestamp;

        randomSeed = (block.timestamp + block.difficulty) % 100;
        console.log("Random # generated:", randomSeed);
        uint256 prizeAmount = 0.0001 ether;
        if (randomSeed <= 50) {
            console.log("%s selected to receive ETH", msg.sender);
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from the contract.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
        _waveBalance[msg.sender].push(Wave(msg.sender, _message, block.timestamp));
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWavesForAddress(address waver_address) public view returns (Wave[] memory waves_per_address) {
        if (_waveBalance[waver_address].length > 0) {
            return _waveBalance[waver_address];
        } 
        // If no waves found, revert the transaction.
        revert();
    }
}
