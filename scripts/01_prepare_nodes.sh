#!/bin/bash

BIN="./polygon-edge"

for i in {1..15}
do
    echo "Initializing secrets for test-chain-$i"
    $BIN secrets init --data-dir "nodes/test-chain-$i" --insecure
done