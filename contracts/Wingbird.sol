//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

// User Struct for interaction with the Platform
contract Wingbird is Ownable {
    // PHASE0 TUTORIAL, USER CREATION, AND FIRST SEEDS

    struct Bird {
        string nickName;
        uint256 color;
        string imgURL;
    }

    enum EggColors {
        RED,
        GREE,
        PURPLE
    }

    // Mappings for different dataTypes
    mapping(address => Bird) birdsOnThePlatform;
    mapping(uint256 => EggColors) public colorIdToEgg;
    mapping(address => uint256) public birdSeeds;

    //events
    event userCreated(address _userAddress);
    event userFunded(address _userAddress, uint256 _amount);
    event honorSent(uint256 _amount);

    // Creates user passing the chosen nickname, the address, the color of the egg.
    // The IMG should be URL stored on IPFS

    function createNewUser(
        string memory _nickname,
        address _userAddress,
        uint256 _color,
        string memory _imgURL
    ) public {
        // Replace this when using a current ERC20 TOKEN
        Bird memory user = Bird(_nickname, _color, _imgURL);
        birdsOnThePlatform[_userAddress] = user;
        BirdHonors memory birdHonors = BirdHonors(0, 0, 0, 0, 0);
        birdHonor[_userAddress] = birdHonors;
        emit userCreated(_userAddress);
    }

    // Give Seeds to user
    // NOTE: should change this to an actual ERC20
    function giveInitialSeeds(address _bird, uint256 _amount) public onlyOwner {
        require(_amount >= 10, "The Minimum amount should be 10");
        birdSeeds[_bird] = _amount;
        emit userFunded(_bird, _amount);
    }

    //TODO: assing the egg color to the index.
    function mapColors() internal {}

    function getUser(address _bird) public view returns (Bird memory) {
        return birdsOnThePlatform[_bird];
    }

    function getUserBalance(address _bird) public view returns (uint256) {
        return birdSeeds[_bird];
    }

    function getEggColor(uint256 _color) public view returns (EggColors) {
        return colorIdToEgg[_color];
    }

    // PHASE 1 PVP AND HONOR SYSTEM, and Honor Getting
    struct BirdHonors {
        uint256 OwlPoints;
        uint256 EaglePoints;
        uint256 PeacockPoints;
        uint256 HummingbirdPoints;
        uint256 PenguinPoints;
    }

    enum BirdRoles {
        EAGLE,
        OWL,
        PEACOCK,
        PENGUIN,
        HUMMINGBIRD
    }

    BirdRoles birds;

    //Mappings
    mapping(address => BirdHonors) birdHonor;

    //functions

    // Spend token for honor system.
    // NOTE: should also replace with actual ERC20 token.
    function giveHonors(uint256 _amount) public {
        require(_amount == 1);
        birdSeeds[msg.sender] = birdSeeds[msg.sender] - 1;
        emit honorSent(_amount);
    }

    // set the final puntuation for the bird, based on the honorSent

    function setFinalHonors(
        uint256 _owl,
        uint256 _eagle,
        uint256 _peacock,
        uint256 _penguin,
        uint256 _hummingbird,
        address _bird
    ) public {
        birdHonor[_bird].EaglePoints = _eagle;
        birdHonor[_bird].OwlPoints = _owl;
        birdHonor[_bird].PenguinPoints = _penguin;
        birdHonor[_bird].HummingbirdPoints = _hummingbird;
        birdHonor[_bird].PeacockPoints = _peacock;
    }

    function getFinalHonors(address _bird)
        public
        view
        returns (BirdHonors memory)
    {
        return birdHonor[_bird];
    }
}
