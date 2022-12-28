#!/bin/bash

# nohup cosmovisor run start --home /Users/xuxinlai/my/mul/workuptick-test> \
# /Users/xuxinlai/my/mul/new/uptick-test/cosmovisor/node.log 2>&1 & 

#chain params 
CHAIN_DIR=./data

##chain1 uptick
BINARY_1=uptickd
CHAINID_1=uptick_7000-1

P2PPORT_1=26656
RPCPORT_1=26657
RPCAPPPORT_1=26658
RESTPORT_1=1316
ROSETTA_1=8080

GRPCPORT_1=8090
GRPCWEB_1=8091

TRACE=""
LOGLEVEL="info"


cosmovisor run start $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0auptick \
--json-rpc.api eth,txpool,personal,net,debug,web3 \
--log_format json --home $CHAIN_DIR/$CHAINID_1 \
--pruning=nothing --grpc.address="0.0.0.0:$GRPCPORT_1" \
--grpc-web.address="0.0.0.0:$GRPCWEB_1" > $CHAIN_DIR/$CHAINID_1.log 2>&1 &
