// SPDX-Identifier-License:MIT

pragma solidity >=0.6.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Interfaceerc721.sol";

contract Nft is Inft, ERC721 {
    constructor(string memory name, string memory symbol)
        ERC721("name", "symbol")
    {
        _safeMint(msg.sender, 1);
    }

    function safeMint(address to, uint tokenId) public {
        _safeMint(to, tokenId);
    }

    function transfer(address recipient, uint tokenId) public {
        _transfer(msg.sender, recipient, tokenId);
    }
}
