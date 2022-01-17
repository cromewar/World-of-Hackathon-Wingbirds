//SPDX-Liense-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.0;

contract BirdSeedsToken is ERC20, Ownable {
    uint256 public maxSupply = 1000 * 10**18;

    constructor() ERC20("Bird Seeds", "BSEED") {
        _mint(msg.sender, maxSupply);
    }

    // Transfer Tokens to the player after finishing the tutorial mini games.
    function transferToBird(address to, uint256 amount) public onlyOwner {
        transfer(to, amount);
    }

    function approveWingBirdContract(address _tokenAddress) public onlyOwner {
        approve(_tokenAddress, maxSupply);
    }
}
