// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {TestBaseV1} from "./TestBaseV1.sol";
import {HorseStoreV1} from "../src/HorseStoreV1.sol";
import {IHorseStoreV1} from "../src/interfaces/IHorseStoreV1.sol";

contract SolidityTestV1 is TestBaseV1 {
    function setUp() public {
        horseStore = IHorseStoreV1(new HorseStoreV1());
    }
}
