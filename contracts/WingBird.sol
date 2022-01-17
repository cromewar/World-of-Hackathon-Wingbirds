//SPD-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WingBird is Ownable {
    address payable[] public birds;
    uint256 internal paymentToHonor = 1;
    address[] public allowedTokens;
    IERC20 public birdSeedToken;
    // Maps How many seeds the user have staked
    mapping(address => mapping(address => uint256)) public stakedSeeds;

    function giveHonors() public payable {
        require(
            birdSeedToken.transferFrom(
                msg.sender,
                address(this),
                paymentToHonor
            )
        );
    }

    function stakeSeeds(uint256 _amount, address _token) public {
        require(_amount > 0, "Amount must be grater than 0");
        require(justStakeSeeds(_token), "You can just stake seeds");
        IERC20(_token).transferFrom(msg.sender, address(this), _amount);

        stakedSeeds[_token][msg.sender] =
            stakedSeeds[_token][msg.sender] +
            _amount;
    }

    // prevents users to stake any other token than the ERC20 BirdSeeds Token
    function justStakeSeeds(address _token) public view returns (bool) {
        for (
            uint256 allowedTokenIndex = 0;
            allowedTokenIndex < allowedTokens.length;
            allowedTokenIndex++
        ) {
            if (allowedTokens[allowedTokenIndex] == _token) {
                return true;
            }
        }
        return false;
    }

    // Add allowed tokens for stake, meant to be used just for seeds or another token on the future
    function addToken(address _token) public onlyOwner {
        allowedTokens.push(_token);
    }

    //Reward the winners with all staking pool
    function winningBirds() public onlyOwner {
        //TODO: reward the winners
    }
}
