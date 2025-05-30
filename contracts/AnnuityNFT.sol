// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract AnnuityNFT is ERC721Enumerable {
    uint256 public nextTokenId;
    address public vault;

    constructor(address _vault) ERC721("Annuity NFT", "ANNFT") {
        vault = _vault;
    }

    function mint(address to) external returns (uint256) {
        require(msg.sender == vault, "Only vault can mint");
        uint256 tokenId = nextTokenId;
        _safeMint(to, tokenId);
        nextTokenId++;
        return tokenId;
    }
}