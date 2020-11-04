# Bootnode

Contains a pre-generated private / pubkey pair to be used by the bootnode
and its connecting nodes. The bootnode should use `--nodekey ./boot.key` while
the connecting nodes should use `--bootnodes=enode://${cat ./boot.pubkey}@${BOOTNODE_IP}:30303`
