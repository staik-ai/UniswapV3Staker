// SPDX-License-Identifier: UNLICENSED

//     ███████╗████████╗ █████╗ ██╗██╗  ██╗    █████╗ ██╗
//     ██╔════╝╚══██╔══╝██╔══██╗██║██║ ██╔╝   ██╔══██╗██║
//     ███████╗   ██║   ███████║██║█████╔╝    ███████║██║
//     ╚════██║   ██║   ██╔══██║██║██╔═██╗    ██╔══██║██║
//     ███████║   ██║   ██║  ██║██║██║  ██╗██╗██║  ██║██║
//     ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═╝

pragma solidity ^0.8.0;
pragma abicoder v2;

contract CalculateIncentiveHash {

struct IncentiveKey {
   address rewardToken;
   address pool;
   uint256 startTime;
   uint256 endTime;
   address refundee;
}

// Return unhashed value used for staking via safeTransfer in the "NFT position manager" contract.
function getUnhashedKey(IncentiveKey memory key)  public pure returns (bytes memory) {
       return abi.encode(key);
   }
   
// Return hashed value used for staking view functions in "Ranch" contract.
function getHashedKey(IncentiveKey memory key)  public pure returns (bytes32 incentiveId) {
       return keccak256(computeUnhashedKey(key));
   }
   
// Error-checking. Used purely to check the unhashed key produces the orignal key/tuple
function decodeUnhashedKey(bytes memory data) public pure returns (IncentiveKey memory) {
        return abi.decode(data, (IncentiveKey));
    }
}
