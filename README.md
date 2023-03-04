# UniswapV3Staker
staking for V3 NFT's

![V3 Staking](https://github.com//staik-ai/UniswapV3Staker/blob/main/v3staking.png?raw=true)

There are several contracts to be acquainted with before proceeding:

..* Uniswap V3 NFT position manager (contract address: TBC)
..* Ranch (Uniswap V3) staker contract (contract address: TBC)  
..* Token 0 - STAIK (contract address: TBC)  
..* Token 1 - USDC (contract address: 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8)  
..* Reward token: STAIK  

After a pool is created, there will be a STAIK/USDC pool address.  
There will also be a Uniswap NFT representing the position, and the NFT will have a token ID number.

## Reward Creation

We first approve the Ranch V3 staker contract to accept STAIK as reward tokens

STAIK ERC20 contract “approve” function parameters:

example spender: 0xabc1230000000000000000000000000001 // (ranch contract address)
example amount: 1000,000,000,000,000,000,000 // (1000 STAIK)

## Creating a tuple

There are several properties in the ranch staking incentive object.

..* Reward token address - Example: 0xAbe0f…111a (STAIK)
..* STAIK/USDC Pool address - Example: 0xcccc…ffff (STAIK/USDC)
..* Start date / End date — Example: 1663607753, 1666022484 (epoch)
..* Refundee — address of STAIK multisig wallet 

We then form all of these values in the tuple format:

["Reward token address", "Pool address", start date, end date, "Refundee"]
In this case, the incentive key tuple is:

We also pass the reward token amount. Make sure to pass the absolute value. For example: 1000 tokens = 1000 * 10 ** 18 = **1000**000000000000000000
