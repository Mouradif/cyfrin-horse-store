// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.20;

import {IERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import {IERC721Metadata} from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

/*
 * @title IHorseStore
 * @author equestrian_lover_420
 */
interface IHorseStoreV2 is IERC721Metadata, IERC721Enumerable {
    function HORSE_HAPPY_IF_FED_WITHIN() external view returns(uint256);
    function horseIdToFedTimeStamp(uint256 horseId) external view returns(uint256);

    function mintHorse() external;
    function feedHorse(uint256 horseId) external;
    function isHappyHorse(uint256 horseId) external view returns (bool);

}
