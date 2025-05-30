// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SShareToken is ERC20 {
    address public admin;

    constructor() ERC20("SShare Token", "SSHARE") {
        admin = msg.sender;
        _mint(msg.sender, 1_000_000 * 10 ** decimals()); // Initial supply
    }

    function mint(address to, uint amount) external {
        require(msg.sender == admin, "Only admin can mint");
        _mint(to, amount);
    }
}