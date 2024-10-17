## BALANCER HOOKS

https://balancer.fi/

Init:

```shell
$ forge init

$ forge install https://github.com/balancer/balancer-v3-monorepo

$ forge install OpenZeppelin/openzeppelin-contracts
```

Remappings in remappings.txt file:

- @test/=lib/balancer-v3-monorepo/pkg/

- @balancer-labs/v3-solidity-utils/=lib/balancer-v3-monorepo/pkg/solidity-utils/

- @balancer-labs/v3-pool-utils/=lib/balancer-v3-monorepo/pkg/pool-utils/

- @balancer-labs/v3-interfaces/=lib/balancer-v3-monorepo/pkg/interfaces/

- @balancer-labs/v3-pool-weighted/=lib/balancer-v3-monorepo/pkg/pool-weighted/

- @balancer-labs/v3-vault/=lib/balancer-v3-monorepo/pkg/vault/

- @openzeppelin/=lib/openzeppelin-contracts/

https://book.getfoundry.sh/

https://github.com/balancer/balancer-v3-monorepo

https://www.openzeppelin.com/solidity-contracts

Useful commands:

```shell
$ forge compile

$ forge build

$ forge test
```

```shell

$ forge create --rpc-url <your_rpc_url> --private-key <your_private_key> src/MyContract.sol:MyContract

$ forge verify-contract \
    --chain-id 11155111 \
    --num-of-optimizations 1000000 \
    --watch \
    --constructor-args $(cast abi-encode "constructor(string,string,uint256,uint256)" "ForgeUSD" "FUSD" 18 1000000000000000000000) \
    --etherscan-api-key <your_etherscan_api_key> \
    --compiler-version v0.8.10+commit.fc410830 \
    <the_contract_address> \
    src/MyToken.sol:MyToken
```

![Hooks](./img/hooks.png?raw=true "Hooks")
