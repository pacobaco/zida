// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AnnuityVault {
    IERC20 public sshareToken;
    address public admin;

    struct Annuity {
        address beneficiary;
        uint256 balance;
        uint256 payoutRate; // per block
        uint256 lastPayoutBlock;
    }

    mapping(uint256 => Annuity) public annuities;
    uint256 public annuityCounter;

    constructor(address _sshareToken) {
        sshareToken = IERC20(_sshareToken);
        admin = msg.sender;
    }

    function createAnnuity(address beneficiary, uint256 depositAmount, uint256 payoutRate) external {
        require(sshareToken.transferFrom(msg.sender, address(this), depositAmount), "Transfer failed");
        annuities[annuityCounter] = Annuity(beneficiary, depositAmount, payoutRate, block.number);
        annuityCounter++;
    }

    function claim(uint256 id) external {
        Annuity storage annuity = annuities[id];
        require(msg.sender == annuity.beneficiary, "Not beneficiary");

        uint256 blocksElapsed = block.number - annuity.lastPayoutBlock;
        uint256 payout = blocksElapsed * annuity.payoutRate;
        if (payout > annuity.balance) {
            payout = annuity.balance;
        }

        annuity.balance -= payout;
        annuity.lastPayoutBlock = block.number;
        sshareToken.transfer(annuity.beneficiary, payout);
    }
}