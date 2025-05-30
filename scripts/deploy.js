const hre = require("hardhat");

async function main() {
  const SShare = await hre.ethers.getContractFactory("SShareToken");
  const sshare = await SShare.deploy();
  await sshare.deployed();

  const Vault = await hre.ethers.getContractFactory("AnnuityVault");
  const vault = await Vault.deploy(sshare.address);
  await vault.deployed();

  const NFT = await hre.ethers.getContractFactory("AnnuityNFT");
  const nft = await NFT.deploy(vault.address);
  await nft.deployed();

  console.log("Deployed contracts:");
  console.log("SShareToken:", sshare.address);
  console.log("AnnuityVault:", vault.address);
  console.log("AnnuityNFT:", nft.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});