// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.20;

import {IHorseStoreV1} from "./interfaces/IHorseStoreV1.sol";

contract HorseStoreV1 is IHorseStoreV1 {
    uint256 numberOfHorses;

    function updateHorseNumber(uint256 newNumberOfHorses) external {
        numberOfHorses = newNumberOfHorses;
    }

    function readNumberOfHorses() external view returns (uint256) {
        return numberOfHorses;
    }
}
