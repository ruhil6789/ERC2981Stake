//SPDX-License-Identifier;MIT

pragma solidity >=0.6.0 <0.9.0;
import "./Nft.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";
import "./Interfaceerc721.sol";

contract Stake is ERC2981 {
    //address immutable Nft;
    IERC721 public immutable Nft;
    uint royaltyAmt;

    constructor(address _nft) {
        Nft = IERC721(_nft);
    }

    struct royaltInfo {
        uint salePrice;
        address creator;
    }

    royaltInfo public royalty;
    mapping(uint => royaltInfo) public royalties;

    // function mint(address creator, uint tokenId) public payable {
    //     royalties[tokenId].creator = msg.sender;
    //     royalties[tokenId].salePrice = msg.value;
    //     //royaltInfo memory royalty = royalties[tokenId];
    // }

    function buy(uint tokenId,address _address) public payable {
        royaltInfo memory roylty = royalties[tokenId];

        console.log("tokenId is there");
        if (Nft.ownerOf(tokenId) == royalties[tokenId].creator) {
            payable(roylty.creator).transfer(msg.value);
        } else {
            uint royaltyAmount = (roylty.salePrice /
                ERC2981._feeDenominator()) * royaltyAmt;
            // payable(roylty.creator).transfer(msg.value);

            payable(roylty.creator).transfer(royaltyAmount);
            payable(Nft.ownerOf(tokenId)).transfer(msg.value - royaltyAmount);
               
        }
        Nft.transferFrom(msg.sender,_address , tokenId);


        //ERC2981.royaltyInfo(tokenId, royalties[tokenId].salePrice);
    }
}
