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

// Return value used for staking via safeTransfer in the "NFT position manager" contract.
function computeUnhashedKey(IncentiveKey memory key)  public pure returns (bytes memory) {
       return abi.encode(key);
   }
// Return value used for staking view functions in "Uniswap V3 staker" contract.
function compute(IncentiveKey memory key)  public pure returns (bytes32 incentiveId) {
       return keccak256(computeUnhashedKey(key));
   }
// Decoding unhashed key.
function decode(bytes memory data) public pure returns (IncentiveKey memory) {
        return abi.decode(data, (IncentiveKey));
    }
}
