// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./ERC721.sol";

contract NFT is ERC721 {

    uint private _cap = type(uint256).max;
    bool private immutable _fixedSupply;

    constructor( bool fixedSupply) ERC721("Sandbox", "SAND") {
        _fixedSupply = fixedSupply;
    }

    function setHardCap(uint _hardCap) external {
        require(_fixedSupply, "Token Supply is set to flexible");
        _cap = _hardCap;
    }

    function isFixedSupply() external view returns(bool){
        return _fixedSupply;
    }  

    function mint(address to, uint tokenId, bytes memory _data) external returns(bool){
        if( _fixedSupply == true){
            require(_cap > totalSupply(), "Total Supply is going over the limit");
        }
        _safeMint(to, tokenId, _data);
        return true;
    }

    function setTokenURI(uint tokenId, string memory _data) external returns(bool) {
        _setTokenURI(tokenId, _data);
    }
}
