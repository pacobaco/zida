# ZIDA - Gas Share Licensing & Annuity dApp

ZIDA is a decentralized finance (DeFi) application that enables the trade and licensing of gas share tokens (S tokens), with long-term yield-bearing annuities built on top of licensed usage rights.

## Features

- Tokenized gas shares (`SShareToken`)
- Annuity NFTs representing claim rights to revenue streams
- On-chain annuity vault with yield distribution
- Smart contract-based licensing and gas cost modeling

## Contracts

- `SShareToken.sol`: ERC-20 token for licensing gas usage
- `AnnuityVault.sol`: Logic for annuity deposits and yield
- `AnnuityNFT.sol`: ERC-721 for annuity entitlements

## Installation

```bash
git clone https://github.com/pacobaco/zida.git
cd zida
npm install
npx hardhat compile
```

## Test

```bash
npx hardhat test
```

## Deployment

```bash
npx hardhat run scripts/deploy.js --network goerli
```

## License

MIT © pacobaco
