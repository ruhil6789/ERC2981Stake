//SPDX-License-identifier:MIT

pragma solidity >=0.6.0 <0.9.0;

interface Inft {
    function safeMint(address to, uint tokenId) external;

    function transfer(address recipient, uint tokenId) external;
}
