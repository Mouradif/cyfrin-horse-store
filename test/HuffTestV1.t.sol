// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {TestBaseV1} from "./TestBaseV1.sol";
import {IHorseStoreV1} from "../src/interfaces/IHorseStoreV1.sol";
import {HuffNeoDeployer} from "foundry-huff-neo/HuffNeoDeployer.sol";

contract HuffTestV1 is TestBaseV1 {
    function setUp() public {
        horseStore = IHorseStoreV1(HuffNeoDeployer.deploy("src/HorseStoreV1.huff"));
    }
}
