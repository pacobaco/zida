const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AnnuityVault and SShareToken", function () {
  let sshare, vault, nft, owner, user;

  beforeEach(async () => {
    [owner, user] = await ethers.getSigners();

    const SShare = await ethers.getContractFactory("SShareToken");
    sshare = await SShare.deploy();
    await sshare.deployed();

    const Vault = await ethers.getContractFactory("AnnuityVault");
    vault = await Vault.deploy(sshare.address);
    await vault.deployed();

    const NFT = await ethers.getContractFactory("AnnuityNFT");
    nft = await NFT.deploy(vault.address);
    await nft.deployed();

    await sshare.transfer(user.address, ethers.utils.parseEther("1000"));
  });

  it("should create annuity and allow claiming", async () => {
    const depositAmount = ethers.utils.parseEther("100");
    const payoutRate = ethers.utils.parseEther("1"); // 1 token per block

    await sshare.connect(user).approve(vault.address, depositAmount);
    await vault.connect(user).createAnnuity(user.address, depositAmount, payoutRate);

    // Simulate a few blocks passing
    for (let i = 0; i < 5; i++) {
      await ethers.provider.send("evm_mine");
    }

    await vault.connect(user).claim(0);
    const balanceAfter = await sshare.balanceOf(user.address);

    expect(balanceAfter).to.be.above(ethers.utils.parseEther("900"));
  });
});