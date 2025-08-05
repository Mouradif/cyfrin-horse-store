// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ERC721Receiver {
    function onERC721Received(address, address, uint256, bytes calldata) external returns (bytes4) {
        return ERC721Receiver.onERC721Received.selector;
    }
}
