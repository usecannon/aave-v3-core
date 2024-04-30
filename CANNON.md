# Aave core cannon package

## Getting Started

### Building the packages

There are 2 core packages to look at, the aave-v3-pool and the aave-v3-tokens packages.
The Aave-v3-pool package contains all the necessary contracts to deploy the pool contract, which is the main point of interaction with aave.
the aave-v3-tokens package imports the pool package and adds aave's token contracts which are fundamental to aave (AToken, VariableDebtToken and StableDebtToken)

To build the packages for the cannon network simply run:

```
PROVIDER_URL=YOUR_PROVIDER_URL PRIVATE_KEY=YOUR_PRIVATE_KEY npx hardhat cannon:build < cannonfile name >
```

To build the packages on a specific network, make sure the network config is defined in `hardhat.config.ts` and run the following:


```
PROVIDER_URL=YOUR_PROVIDER_URL PRIVATE_KEY=YOUR_PRIVATE_KEY npx hardhat cannon:build --network < network_name > < cannonfile_name >
```