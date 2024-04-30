#!/bin/bash

set -e

package=$1
network=$2
chainId=$3

CANNON=${CANNON:-cannon}

if [ "$package" = "pool" ]; then
    echo "Configuring Aave v3 pool"
    if [ "$network" = "sepolia" ]; then

    #Aave uses separate deployments on sepolia to granularly control supplies and this requires us to deploy each Logic Library at a specific address on sepolia
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address InitializableImmutableAdminUpgradeabilityProxy '0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address PoolAddressesProvider '0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address Pool '0x0562453c3DAFBB5e625483af58f4E6D668c44e19'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address BorrowLogic '0x0f154441C7026eDd6A89Cc3A5fAa2f64C7335C80'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address BridgeLogic '0x50360e830f4cc6D9DAa1E74d2a5AD9644fD202c1'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address EModeLogic '0x37dc7863a743fcA4e532bBe6Dee644B87d636ea0'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address LiquidationLogic '0x2e021eead190cd55c0CEeCf308416d0bA0A8a015'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address PoolAddressesProvider '0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address PoolLogic '0x1ce1bA9946C30b4C505631AD9E3E0342877FdE02'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address SupplyLogic '0x77241299fFA12DF99Da6C3d9f195aa298955AEc6'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address FlashLoanLogic '0x5e659d4c0f8a727D00AE70f96a02c4A64f76c5Cb'
        
    elif [ "$network" = "mainnet" ]; then
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address InitializableImmutableAdminUpgradeabilityProxy '0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address PoolAddressesProvider '0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e'
        $CANNON alter aave-v3-pool:1.19.3@main --chain-id $chainId set-contract-address Pool '0x5faab9e1adbddad0a08734be8a52185fd6558e14'
    fi
fi

if [ "$package" = "tokens" ]; then
    echo "Configuring Aave v3 tokens"
    if [ "$network" = "sepolia" ]; then
        $CANNON alter aave-v3-tokens:1.19.3@main --chain-id $chainId set-contract-address AToken '0x48424f2779be0f03cDF6F02E17A591A9BF7AF89f'
        $CANNON alter aave-v3-tokens:1.19.3@main --chain-id $chainId set-contract-address StableDebtToken '0xd1CF2FBf4fb82045eE0B116eB107d29246E8DCe9'
        $CANNON alter aave-v3-tokens:1.19.3@main --chain-id $chainId set-contract-address VariableDebtToken '0x54bdE009156053108E73E2401aEA755e38f92098'
    elif [ "$network" = "mainnet" ]; then
        $CANNON alter aave-v3-tokens:1.19.3@main --chain-id $chainId set-contract-address AToken '0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d'
        $CANNON alter aave-v3-tokens:1.19.3@main --chain-id $chainId set-contract-address StableDebtToken '0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57'
        $CANNON alter aave-v3-tokens:1.19.3@main --chain-id $chainId set-contract-address VariableDebtToken '0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6'
    fi
fi