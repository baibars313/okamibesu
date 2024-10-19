// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//sudo docker-compose -f geth-clique-consensus.yml up
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Staking is Ownable {
    // Token to be staked
    IERC20 public stakingToken;

    // Struct to hold staking details for each user
    struct Staker {
        uint256 amountStaked;
        uint256 stakingStartTime;
        uint256 rewardsClaimed;
    }

    // Mapping from user address to their staking details
    mapping(address => Staker) public stakers;

    // Total staked amount
    uint256 public totalStaked;

    // Reward parameters
    uint256 public rewardPercentage; // e.g. 5 means 5% reward
    uint256 public stakingPeriod; // in minutes

    // Events
    event Staked(address indexed user, uint256 amount);
    event Claimed(address indexed user, uint256 reward);

    constructor(IERC20 _stakingToken) {
        stakingToken = _stakingToken;
        rewardPercentage = 5; // Default reward percentage
        stakingPeriod = 60; // Default staking period in minutes
    }

    // Function to stake tokens
    function stake(uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        
        // Transfer tokens from user to the contract
        stakingToken.transferFrom(msg.sender, address(this), _amount);
        
        // Update staker's information
        Staker storage staker = stakers[msg.sender];
        staker.amountStaked += _amount;
        staker.stakingStartTime = block.timestamp;

        totalStaked += _amount;

        emit Staked(msg.sender, _amount);
    }

    // Function to claim rewards
    function claimRewards() external {
        Staker storage staker = stakers[msg.sender];

        require(staker.amountStaked > 0, "No tokens staked");
        require(block.timestamp >= staker.stakingStartTime + (stakingPeriod * 1 minutes), "Staking period not ended");

        // Calculate rewards
        uint256 reward = (staker.amountStaked * rewardPercentage) / 100;
        staker.rewardsClaimed += reward;

        // Transfer reward to the staker
        stakingToken.transfer(msg.sender, reward);

        emit Claimed(msg.sender, reward);
    }

    // Admin function to set reward percentage
    function setRewardPercentage(uint256 _percentage) external onlyOwner {
        require(_percentage > 0, "Percentage must be greater than 0");
        rewardPercentage = _percentage;
    }

    // Admin function to set staking period
    function setStakingPeriod(uint256 _minutes) external onlyOwner {
        require(_minutes > 0, "Period must be greater than 0");
        stakingPeriod = _minutes;
    }

    // Function to transfer ownership
    function transferOwnership(address newOwner) public override onlyOwner {
        super.transferOwnership(newOwner);
    }

    // Function to get total staked amount of a user
    function getUserStake(address _user) external view returns (uint256) {
        return stakers[_user].amountStaked;
    }
}
