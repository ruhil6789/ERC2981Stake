import {ethers} from "hardhat";
import { Nft, Nft__factory, Stake, Stake__factory } from "../typechain-types";
import {SignerWithAddress} from "@nomiclabs/hardhat-ethers/signers";
import { expect} from"chai";
// import { ethers, ethers } from "ethers";

describe("contract deployment",async()=>{
let  Stake:Stake;
let Nft:Nft;

let owner:SignerWithAddress;
let signers:SignerWithAddress[];

beforeEach("contract deployment",async()=>{

signers = await ethers.getSigners();
owner = signers[0];

Nft = await new Nft__factory(owner).deploy("name","symbol");
Stake = await new Stake__factory(owner).deploy(Nft.address);

})

it("should mint the token", async()=>{

await Nft.connect(owner).safeMint(signers[1].address,10);
console.log("mint the token Id");
console.log("token Is", await Nft.connect(owner).balanceOf(signers[1].address));
})
it("should buy the Nft",async()=>{
await Nft.connect(owner).safeMint(signers[1].address,10);
await Nft.connect(signers[1]).approve(Stake.address, 10);
await Stake.connect(signers[1]).buy(10);
console.log("buy by the buyer");

})

it("should creator  be the  owner of the tokenId",async()=>{
await Nft.connect(owner).safeMint(signers[1].address,10);
await Nft.connect(signers[1]).approve(Stake.address,10);
expect(await Stake.connect(signers[1]).buy(10)).be.equal(Nft.ownerOf(10));
console.log(" successfull  creator be te owner of token id");


})

// let tx = {
//     to: receiverAddress,
//     // Convert currency unit from ether to wei
//     value: ethers.utils.parseEther(amountInEther)
// }
it("should transfer the amount to the owner",async()=>{
await Nft.connect(owner).safeMint(signers[1].address,10);
await Nft.connect(signers[1]).approve(Stake.address,10);
expect(await Stake.connect(signers[1]).buy(10)).be.equal(Nft.ownerOf(10));
console.log(" successfull  creator be te owner of token id");

})
it.only("should transfer the amount  on second buy",async()=>{
await Nft.connect(owner).safeMint(signers[1].address,10);
await Nft.connect(signers[1]).approve(Stake.address,10);
await Stake.connect(signers[1]).buy(10,signers[3].address);
console.log(await Nft.ownerOf(10));
console.log(signers[1].address,signers[3].address);

 await Nft.connect(signers[3]).approve(signers[2].address,10);
 await Nft.connect(signers[3]).transfer(signers[2].address,10);
 await Nft.connect(signers[2]).approve(Stake.address,10);
 await Stake.connect(signers[2]).buy(10,signers[4].address,{value:"1"});
console.log("transfer the amount the  on second buy");

})


})