# PoW Eth Testnet

The docker-compose file creates a Proof of Work Ethereum testnet using the following
configuration:

- 2 geth non-mining nodes
- 1 mining geth node (used as a bootstrap node)
- 2 geth mining nodes (host ports 7545 7546)
- 1 MEV geth mining node (host port 9545)

The 2 non-mining nodes along with the bootstrap node are exposed indirectly
via an nginx load balancer at the host's port 8545.

- The coinbase address for all mined funds can be found under `keys/`
- The genesis file for geth can be found under `geth/geth.json`

Requires docker-compose to be installed. Tested on version 1.27.2.

```
docker-compose build
docker-compose up
```

## TODO
- Add parity node support

