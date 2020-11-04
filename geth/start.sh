#!/usr/bin/env bash

set -e

# initialize (how can we persist?)
cd /root
geth init genesis.json

# Enable the miner API if required, min gasprice = 0
API="--rpcapi personal,eth,net,web3,txpool,admin"
if [[ "$MINER" == 1 ]]; then
    MINE="--mine --minerthreads=1 --etherbase=0xd912aecb07e9f4e1ea8e6b4779e7fb6aa1c3e4d8 --gasprice 0"
    API+=",miner"
else 
    MINE=""
fi

# We assume there's either a `bootnode.key` or 
# `bootnode.pubkey` file at /root depending on if
# the node is the bootnode or a node connecting to 
# the bootnode
BOOTNODE_CMD=""
if [[ "$BOOTNODE" == 1 ]]; then
    BOOTNODE_CMD="--nodekey /root/boot.key"
    echo "Launching bootnode" $BOOTNODE_CMD
else 
    # Get the bootnode's IP and enode and use it
    BOOTNODE_IP=`host bootnode | cut -d" " -f4`
    ENODE=`cat /root/boot.pubkey`
    BOOTNODES="enode://${ENODE}@${BOOTNODE_IP}:30303"
    BOOTNODE_CMD="--bootnodes=$BOOTNODES"
    echo "Launching child node" $BOOTNODE_CMD
fi

# TODO: Use non deprecated CLI args
geth \
    --syncmode=full \
    --rpccorsdomain="*" \
    --rpc \
    --rpcvhosts=* \
    --rpcaddr="0.0.0.0" \
    --allow-insecure-unlock \
    --nousb \
    $API \
    $MINE \
    $BOOTNODE_CMD
