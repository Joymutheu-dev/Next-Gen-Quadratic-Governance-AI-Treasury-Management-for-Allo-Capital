require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
    solidity: "0.8.19",
    networks: {
        sepolia: {
            url: `https://eth-sepolia.alchemyapi.io/v2/${process.env.ALCHEMY_API_KEY}`,
            accounts: [`0x${process.env.PRIVATE_KEY}`]
        }
    }
};