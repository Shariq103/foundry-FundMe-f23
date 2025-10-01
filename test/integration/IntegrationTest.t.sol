// SPDX-License-Identifier: MIT

pragma solidity ^0.8.29;

import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundMe} from "../../src/FundMe.sol";
import {Test, console} from "forge-std/Test.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interaction.s.sol";

contract IntegrationTest is Test {
    FundMe public fundMe;

    address USER = makeAddr("user");
    uint256 public constant SEND_VALUE = 0.1 ether; // just a value to make sure we are sending enough!
    uint256 public constant STARTING_BALANCE = 10 ether;
    uint256 public constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deployer = new DeployFundMe();
        fundMe = deployer.run();
        vm.deal(USER, STARTING_BALANCE);
    }
    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance, 0);
    }
}
