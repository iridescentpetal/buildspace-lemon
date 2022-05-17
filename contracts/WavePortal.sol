// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping (address => uint256) private _waveBalance;

    constructor() {
        console.log("Waving from the WavePortal ~~~~");
    }

    function wave() public {
        totalWaves++;
        console.log("%s has waved!", msg.sender);
        _waveBalance[msg.sender]++;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getTotalWavesForAddress(address waver) public view returns (uint256) {
        return _waveBalance[waver];
    }
}
