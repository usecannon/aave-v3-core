import path from 'path';
import { HardhatUserConfig } from 'hardhat/types';
// @ts-ignore
import { accounts } from './test-wallets.js';
import { COVERAGE_CHAINID, HARDHAT_CHAINID } from './helpers/constants';
import { buildForkConfig } from './helper-hardhat-config';

require('dotenv').config();

import '@nomicfoundation/hardhat-toolbox';
import '@tenderly/hardhat-tenderly';
import 'hardhat-contract-sizer';
import 'hardhat-dependency-compiler';
import '@nomicfoundation/hardhat-chai-matchers';

import 'hardhat-cannon';

import { DEFAULT_NAMED_ACCOUNTS } from '@aave/deploy-v3';

const DEFAULT_BLOCK_GAS_LIMIT = 12450000;
const HARDFORK = 'london';

const hardhatConfig = {
  defaultNetwork: 'cannon',
  gasReporter: {
    enabled: true,
  },
  contractSizer: {
    alphaSort: true,
    runOnCompile: false,
    disambiguatePaths: false,
  },
  solidity: {
    // Docs for the compiler https://docs.soliditylang.org/en/v0.8.10/using-the-compiler.html
    version: '0.8.10',
    settings: {
      optimizer: {
        enabled: true,
        runs: 100000,
      },
      evmVersion: 'london',
    },
  },
  typechain: {
    outDir: 'types',
    target: 'ethers-v5',
  },
  mocha: {
    timeout: 0,
    bail: true,
  },
  tenderly: {
    project: process.env.TENDERLY_PROJECT || '',
    username: process.env.TENDERLY_USERNAME || '',
    forkNetwork: '1', //Network id of the network we want to fork
  },
  networks: {
    coverage: {
      url: 'http://localhost:8555',
      chainId: COVERAGE_CHAINID,
      throwOnTransactionFailures: true,
      throwOnCallFailures: true,
    },
    local: {
      url: 'http://localhost:8545',
      chainId: 31337,
      gas: 12000000, // Prevent gas estimation for better error results in tests
    },
    mainnet: {
      url: process.env.PROVIDER_URL,
      chainId: 1,
      accounts: process.env.PRIVATE_KEY?.split(','),
      gas: DEFAULT_BLOCK_GAS_LIMIT,
    },
    sepolia: {
      url: process.env.PROVIDER_URL,
      chainId: 11155111,
      accounts: process.env.PRIVATE_KEY?.split(','),
    },
    hardhat: {
      hardfork: HARDFORK,
      blockGasLimit: DEFAULT_BLOCK_GAS_LIMIT,
      gas: DEFAULT_BLOCK_GAS_LIMIT,
      gasPrice: 8000000000,
      chainId: HARDHAT_CHAINID,
      throwOnTransactionFailures: true,
      throwOnCallFailures: true,
      forking: buildForkConfig(),
      allowUnlimitedContractSize: true,
      accounts: accounts.map(({ secretKey, balance }: { secretKey: string; balance: string }) => ({
        privateKey: secretKey,
        balance,
      })),
    },
    cannon: {
      accounts: accounts.map(({ secretKey }: { secretKey: string; balance: string }) => secretKey),
      url: 'http://localhost:8545',
      chainId: 13370,
      publicSourceCode: true,
    },
    ganache: {
      url: 'http://localhost:8545',
      accounts: {
        mnemonic:
          'summer frozen alley foot sausage stairs become shoulder relax inmate quantum success',
        path: "m/44'/60'/0'/0",
        initialIndex: 0,
        count: 20,
      },
    },
  },
  external: {
    contracts: [
      {
        artifacts: './temp-artifacts',
        deploy: 'node_modules/@aave/deploy-v3/dist/deploy',
      },
    ],
  },
};

export default hardhatConfig;
