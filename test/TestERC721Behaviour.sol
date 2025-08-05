// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {TestBaseV2} from "./TestBaseV2.sol";
import {ERC721Receiver} from "./ERC721Receiver.sol";

abstract contract TestERC721Behaviour is TestBaseV2 {
    string internal constant NFT_NAME = "HorseStore";
    string internal constant NFT_SYMBOL = "HS";

    function testName() public view {
        string memory name = horseStore.name();
        assertEq(name, NFT_NAME);
    }

    function testSymbol() public view {
        string memory name = horseStore.symbol();
        assertEq(name, NFT_SYMBOL);
    }

    function testSupportsInterface() public {
        assertEq(horseStore.supportsInterface(0x12312300), false);
        assertEq(horseStore.supportsInterface(0x01ffc9a7), true);
        assertEq(horseStore.supportsInterface(0x80ac58cd), true);
        assertEq(horseStore.supportsInterface(0x5b5e139f), true);
        assertEq(horseStore.supportsInterface(0x780e9d63), true);
        assertEq(horseStore.supportsInterface(0xb8cf3a3d), true);
    }

    function testTotalSupply(uint8 iterations) public {
        vm.assume(iterations > 0);

        for (uint256 i = 0; i < iterations; ++i) {
            assertEq(horseStore.totalSupply(), i);
            address user = address(uint160(uint256(keccak256(abi.encodePacked(i)))));
            vm.prank(user);
            horseStore.mintHorse();
        }
        assertEq(horseStore.totalSupply(), iterations);
    }

    function testBalance(uint8 iterations) public {
        vm.assume(iterations > 0);

        address user = makeAddr("user");
        vm.startPrank(user);
        for (uint256 i = 0; i < iterations; ++i) {
            assertEq(horseStore.balanceOf(user), i);
            horseStore.mintHorse();
        }
        vm.stopPrank();
        assertEq(horseStore.balanceOf(user), iterations);
    }

    function testOwnership(uint8 iterations) public {
        vm.assume(iterations > 0);

        for (uint256 i = 0; i < iterations; ++i) {
            uint256 tokenId = horseStore.totalSupply();
            address user = address(uint160(uint256(keccak256(abi.encodePacked(i)))));
            vm.prank(user);
            horseStore.mintHorse();
            assertEq(horseStore.ownerOf(tokenId), user);
        }
    }

    function testTransfer() public {
        address userA = makeAddr("userA");
        address userB = makeAddr("userB");

        vm.startPrank(userA);
        horseStore.mintHorse();
        horseStore.transferFrom(userA, userB, 0);
        vm.expectRevert();
        horseStore.transferFrom(userB, userA, 0);
        vm.stopPrank();
    }

    function testSafeTransfer() public {
        address userA = makeAddr("userA");
        address userB = makeAddr("userB");

        vm.startPrank(userA);
        horseStore.mintHorse();
        horseStore.safeTransferFrom(userA, userB, 0);
        assertEq(horseStore.ownerOf(0), userB);
        vm.stopPrank();
        vm.startPrank(userB);
        vm.expectRevert();
        horseStore.safeTransferFrom(userB, address(this), 0);
        vm.stopPrank();

        address receiver = address(new ERC721Receiver());
        vm.prank(userB);
        horseStore.safeTransferFrom(userB, receiver, 0);

        assertEq(horseStore.ownerOf(0), receiver);
    }

    function testApprove() public {
        address userA = makeAddr("userA");
        address userB = makeAddr("userB");

        vm.prank(userA);
        horseStore.mintHorse();
        assertEq(horseStore.getApproved(0), address(0));
        vm.prank(userB);
        vm.expectRevert();
        horseStore.approve(userB, 0);
        vm.prank(userA);
        horseStore.approve(userB, 0);
        assertEq(horseStore.getApproved(0), userB);
        vm.prank(userB);
    }

    function testSpendApproval() public {
        address userA = makeAddr("userA");
        address userB = makeAddr("userB");
        address userC = makeAddr("userC");

        vm.startPrank(userA);
        horseStore.mintHorse();
        horseStore.approve(userB, 0);
        vm.stopPrank();
        assertEq(horseStore.ownerOf(0), userA);
        vm.startPrank(userB);
        horseStore.transferFrom(userA, userC, 0);
        assertEq(horseStore.ownerOf(0), userC);
        vm.expectRevert();
        horseStore.transferFrom(userC, userB, 0);
        vm.stopPrank();
    }
}
