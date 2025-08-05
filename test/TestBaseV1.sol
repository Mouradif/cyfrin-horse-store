// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IHorseStoreV1} from "../src/interfaces/IHorseStoreV1.sol";
import {Test} from "forge-std/Test.sol";

abstract contract TestBaseV1 is Test {
    IHorseStoreV1 internal horseStore;

    function testReadCount() public view {
        uint256 initalValue = horseStore.readNumberOfHorses();
        assertEq(initalValue, 0);
    }

    function testStoreAndReadHorseNumber() public {
        uint256 numberOfHorses = 77;
        horseStore.updateHorseNumber(numberOfHorses);
        assertEq(horseStore.readNumberOfHorses(), numberOfHorses);
    }
}
