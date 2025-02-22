const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();

    console.log("Deploying contracts with:", deployer.address);

    const Voting = await hre.ethers.getContractFactory("AlloCapitalVoting");
    const voting = await Voting.deploy();
    await voting.deployed();
    console.log("Voting Contract deployed to:", voting.address);

    const Treasury = await hre.ethers.getContractFactory("AlloTreasuryManager");
    const treasury = await Treasury.deploy("0xYourTokenAddressHere");
    await treasury.deployed();
    console.log("Treasury Contract deployed to:", treasury.address);

    const ZKVerifier = await hre.ethers.getContractFactory("ZKIdentityVerifier");
    const zkVerifier = await ZKVerifier.deploy();
    await zkVerifier.deployed();
    console.log("ZK Identity Verifier deployed to:", zkVerifier.address);
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});