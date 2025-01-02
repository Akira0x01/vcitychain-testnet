#!/bin/bash

BIN="./polygon-edge"
GENESIS="./genesis.json"

rm -f $GENESIS

$BIN genesis \
    --name "vcity-testnet" \
    --consensus ibft \
    --ibft-validator-type ecdsa \
    --block-gas-limit 20000000 \
    --dir $GENESIS \
    --chain-id 20230826 \
    --max-validator-count 217 \
    --native-token-config vcitychain:VCITY:18:false \
    --premine 0x4BCBB0e87ff0Bd8c6bD4968617b17b2e2DC12EBe:10000000000000000000000000000 \
    --validators=0x6DBe404e4805E98dD1E4421520fd8F318BC837e4 \
    --validators=0xA4d6DD83875af6f29f1bf83ec51d343507702ab7 \
    --validators=0x0e4f49785d6Ca8F2d00079083F480F313049B406 \
    --validators=0x1b6B530660dd99d5188296867e66FB99556F9CBD \
    --bootnode /dns/node2.vcity.app/tcp/1478/p2p/16Uiu2HAm4rovZtyEEjy4vqGxvEtFdChTugZEosbjSG1JX1wpLEUJ \
    --bootnode /dns/node5.vcity.app/tcp/1478/p2p/16Uiu2HAm54fsrSe2QKmbZGmzDygTvtv5UDyXerkiw2s5svq8vXDQ