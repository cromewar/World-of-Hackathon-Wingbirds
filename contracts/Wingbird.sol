//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

// User Struct for interaction with the Platform
contract Wingbird is Ownable, VRFConsumerBase {
    // CHainlink random number generation
    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;

    constructor(
        address _vrfCoordinator,
        address _link,
        uint256 _fee,
        bytes32 _keyhash
    ) VRFConsumerBase(_vrfCoordinator, _link) {
        keyHash = _keyhash;
        fee = _fee; // 0.1 LINK (Varies by network)
    }

    function getRandomNumber() public {
        require(
            LINK.balanceOf(address(this)) >= fee,
            "Not enough LINK - fill contract with faucet"
        );
        bytes32 requestId = requestRandomness(keyHash, fee);
        emit RequestedRandomness(requestId);
    }

    function fulfillRandomness(bytes32 _requestId, uint256 _randomness)
        internal
        override
    {
        require(_randomness > 0, "random not found");
        randomResult = _randomness;
    }

    // PHASE0 TUTORIAL, USER CREATION, AND FIRST SEEDS

    // Each bird Represents a user.
    struct User {
        string nickName;
        string imgURL;
        uint256 randomNumber;
    }

    enum EggColors {
        RED,
        GREE,
        PURPLE
    }

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

    struct IpfsInfo {
        string ipfs_cid;
        address[] _birds;
    }

    BirdRoles birds;

    address[] totalBirdsOnPlatform;

    // Mappings for different dataTypes
    mapping(address => User) birdsOnThePlatform;
    mapping(uint256 => EggColors) public colorIdToEgg;
    mapping(address => uint256) public birdSeeds;
    mapping(address => BirdHonors) birdHonor;
    mapping(string => IpfsInfo) ipfsCids;

    //events
    //chainlink suff
    event RequestedRandomness(bytes32 requestId);
    //contract
    event userCreated(address _userAddress);
    event userFunded(address _userAddress, uint256 _amount);
    event honorSent(uint256 _amount);

    // phase1
    // NOTE: Which other parameters the emet should emit?
    event missionOneCompleted(string _ipfs_cid);
    event missionTwoConsensusCompleted(string _ipfs_cid, bool _consensus);

    //events for storage phase1

    // Creates user passing the chosen nickname, the address, the color of the egg.
    // The IMG should be URL stored on IPFS
    // This is the first function to call from the RPG
    function createNewUser(string memory _nickname, string memory _imgURL)
        public
    {
        // Replace this when using a current ERC20 TOKEN
        require(getUserBalance(msg.sender) == 0, "User already exists!");
        getRandomNumber();
        User memory user = User(_nickname, _imgURL, randomResult);
        birdsOnThePlatform[msg.sender] = user;
        BirdHonors memory birdHonors = BirdHonors(0, 0, 0, 0, 0);
        birdHonor[msg.sender] = birdHonors;
        totalBirdsOnPlatform.push(msg.sender);
        giveInitialSeeds(msg.sender, 100); // Hardcoded 100 seeds
        emit userCreated(msg.sender);
    }

    // Give Seeds to user
    // NOTE: should we change this to an actual ERC20?
    // THe amoun should be decided by hackathon organizers, for MVP is Hardcoded.
    function giveInitialSeeds(address _bird, uint256 _amount) internal {
        require(_amount >= 100, "The Minimum amount should be 100");
        birdSeeds[_bird] = _amount;
        emit userFunded(_bird, _amount);
    }

    function getUser(address _bird) public view returns (User memory) {
        return birdsOnThePlatform[_bird];
    }

    function getUserBalance(address _bird) public view returns (uint256) {
        return birdSeeds[_bird];
    }

    function getTotalBirds() public view returns (uint256) {
        return totalBirdsOnPlatform.length;
    }

    // PHASE 1 PVP AND HONOR SYSTEM, and Honor Getting

    // syncSenses Is the first function of the pvp function
    function syncSenses(
        string memory _ipfs_cid_mission1,
        address[] memory _birds
    ) public {
        require(
            checkAddress(msg.sender, _birds) == true,
            "User does not exists on the group"
        );
        IpfsInfo memory newCid = IpfsInfo(_ipfs_cid_mission1, _birds);
        ipfsCids[_ipfs_cid_mission1] = newCid;
        emit missionOneCompleted(_ipfs_cid_mission1);
    }

    function reachConsensus(
        bool _consensusReached,
        string memory _ipfs_cid_mission2,
        address[] memory _birds
    ) public {
        require(
            checkAddress(msg.sender, _birds) == true,
            "User does not exists on the group"
        );
        require(_consensusReached == true, "Consensus not reached");
        IpfsInfo memory newCid = IpfsInfo(_ipfs_cid_mission2, _birds);
        ipfsCids[_ipfs_cid_mission2] = newCid;
        emit missionTwoConsensusCompleted(
            _ipfs_cid_mission2,
            _consensusReached
        );
    }

    function getIpfsObject(string memory _cid)
        public
        view
        returns (IpfsInfo memory)
    {
        return ipfsCids[_cid];
    }

    // check if the address on a given array
    function checkAddress(address _userAddress, address[] memory _users)
        internal
        pure
        returns (bool)
    {
        bool exist = false;
        for (uint256 i = 0; i < _users.length; i++) {
            if (_users[i] == _userAddress) {
                exist = true;
            }
        }
        return exist;
    }

    // Spend token for honor system.
    // NOTE: should also replace with actual ERC20 token.
    function giveHonors(uint256 _amount) public {
        require(_amount == 10);
        birdSeeds[msg.sender] = birdSeeds[msg.sender] - 10;
        emit honorSent(_amount);
    }

    // Interaction storage functions for IPFS
    function buildFences(string memory _ipfs_cid_mission) public {}

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
