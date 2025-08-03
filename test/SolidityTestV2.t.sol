// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {HorseStoreV2} from "../src/HorseStoreV2.sol";
import {IHorseStoreV2} from "../src/interfaces/IHorseStoreV2.sol";
import {TestBaseV2} from "./TestBaseV2.sol";

contract HorseStoreSolidityV2 is TestBaseV2 {
    function setUp() public {
        horseStore = IHorseStoreV2(new HorseStoreV2());
    }
}
