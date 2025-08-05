// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IHorseStoreV2} from "../src/interfaces/IHorseStoreV2.sol";
import {HuffNeoDeployer} from "foundry-huff-neo/HuffNeoDeployer.sol";
import {TestERC721Behaviour} from "./TestERC721Behaviour.sol";

contract HuffTestV2 is TestERC721Behaviour {
    function setUp() public {
        horseStore = IHorseStoreV2(HuffNeoDeployer.deploy("src/HorseStoreV2.huff"));
    }
}
