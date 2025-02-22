const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AlloCapitalVoting", function () {
    let Voting, voting, owner, addr1, addr2;

    beforeEach(async function () {
        [owner, addr1, addr2] = await ethers.getSigners();
        Voting = await ethers.getContractFactory("AlloCapitalVoting");
        voting = await Voting.deploy();
        await voting.deployed();
    });

    it("Should allow users to vote with quadratic cost", async function () {
        await voting.connect(addr1).castVote(1, 2);
        const voteCount = await voting.projectVotes(1);
        expect(voteCount).to.equal(2);
    });

    it("Should prevent users from exceeding balance", async function () {
        await expect(voting.connect(addr2).castVote(1, 10)).to.be.revertedWith("Insufficient funds");
    });
});