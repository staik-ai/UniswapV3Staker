# UniswapV3Staker
staking for V3 NFT's

![V3 Staking](https://github.com//staik-ai/UniswapV3Staker/blob/main/v3staking.png?raw=true)

There are several contracts to be acquainted with before proceeding:

+ Uniswap V3 NFT position manager (contract address: TBC)
+ Ranch (Uniswap V3) staker contract (contract address: TBC)  
+ Token 0 - STAIK (contract address: TBC)  
+ Token 1 - USDC (contract address: 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8)  
+ Reward token: STAIK  

After a pool is created, there will be a STAIK/USDC pool address.  
There will also be a Uniswap NFT representing the position, and the NFT will have a token ID number.

## Reward Creation

We first approve the Ranch V3 staker contract to accept STAIK as reward tokens

STAIK ERC20 contract “approve” function parameters:

+ example spender: 0xabc123...0001 // (ranch contract address)
+ example amount: 1000,000,000,000,000,000,000 // (1000 STAIK)

## Creating a tuple

There are several properties in the ranch staking incentive object.

+ Reward token address - Example: 0xAbe0f…111a (STAIK)
+ STAIK/USDC Pool address - Example: 0xcccc…ffff (STAIK/USDC)
+ Start date / End date — Example: 1663607753, 1666022484 (epoch)
+ Refundee — address of STAIK multisig wallet 

We then form all of these values in the tuple format:

["Reward token address", "Pool address", start date, end date, "Refundee"]


We also pass the reward token amount. Make sure to pass the absolute value.  
For example: 1000 tokens = 1000 * 10 ** 18 = **1000**000000000000000000

We can now proceed to the **createIncentive()** function in the Ranch V3 contract:

+ key (tuple)
+ reward (uint256)

## Some reasons for possible errors

+ Incorrect pool address
+ The incentive start date is in the past;
+ STAIK reward tokens were not approved;
+ Incentive period is too long (max. duration 730 days (63072000 seconds))

## Calculating the incentive hash keys
We can utilizie the CalculateIncentiveHash smart contract to derive an unhashed incentive key.   
We pass in the key(tuple) we generated into the **getUnhashedKey()** function.  
This returns an **Unhashed incentive key**.  

The **Unhashed incentive key** will be used as data for staking via the Uniswap V3 NFT position manager:

We can also pass in the key(tuple) we generated into the **getHashedkey()** function.  
This returns a **Hashed incentive key**.  

The **Hashed incentive key** will be used for checking values in the ranch contract:

Finally, as a form of error-checking, we can pass the unhashed incentive key into the  
**decodeUnhashedKey()** function if we want to check it produces the original key/tuple.

## Staking your NFT's to the Ranch
Firstly the NFT owner needs to approve transfer of the NFT to the Ranch contract using the approve() function in the   
Uniswap NFT manager contract.  

+ to: 0xabc123...0001 // (Ranch Contract)
+ tokenId: (e.g. 13821) // (The token ID of the NFT being approved)  

Next the **safeTransferFrom()** function must be called to actually transfer the NFT:

+ from: 0xa3b8EAaB1eaF1E6DEAB42b864C93C70E2Eba2e5f // (owner of NFT)
+ to: 0xabc123...0001 // (Ranch Contract)
+ tokenId: (e.g. 13821) // (The token ID of the NFT being approved)  
+ _data: // The complete **Unhashed incentive key**

## Confirm staking NFT was successful
You can confirm if your staking was successful by calling the **getRewardInfo()** function in the Ranch contract, and passing in  
the key/tuple, and the NFT token Id:

You can also confirm how many NFT's have been staked to the ranch, by checking the **incentives()** function.  
This time, pass in the "Hashed Incentive key", which will retunr the number of NFT's staked as a **numberOfStakes** value.

## Unstaking tokens to claim STAIK rewards
Step one is to call the **unstakeToken()** function by passing in the key/tuple and token Id:

+ key (tuple)
+ tokenId (uint256)

Step two is to call the **claimReward()** function by passing in the STAIK token address, the claimers wallet, and the amount of tokens to claim.

+ rewardToken: // STAIK token address
+ to: // claimers wallet address
+ amount: // you can type 0 if you want to claim ALL STAIK rewards you are entitled to

## Recovering your original Uniswap V3 NFT
Use the **withdrawToken()** function to recover your original Uniswap V3 NFT.  

Pass in the NFT token Id, the claimers wallet adddress, and 0 (represented in Hex) as the values:

+ tokenId: (e.g. 13821) 
+ to: // claimers address
+ data: // pass in 0x0









