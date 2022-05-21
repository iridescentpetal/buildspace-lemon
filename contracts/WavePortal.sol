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

    constructor() {
        console.log("I am smart contract // WavePortal ~~~~");
    }

    function wave(string memory _message) public {
        ++totalWaves;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));
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
