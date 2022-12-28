#!/bin/bash

killall uptickd
# cd ../uptick
cd /Users/xuxinlai/my/mul/gon/uptick

make install
cd /Users/xuxinlai/my/mul/workuptick-test

rm -rf data/uptick_7000-1.log

#chain params 
CHAIN_DIR=./data

##chain1 uptick
BINARY_1=uptickd
CHAINID_1=uptick_7000-1

VAL_MNEMONIC_1="clock post desk civil pottery foster expand merit dash seminar song memory figure uniform spice circle try happy obvious trash crime hybrid hood cushion"
DEMO_MNEMONIC_1="banner spread envelope side kite person disagree path silver will brother under couch edit food venture squirrel civil budget number acquire point work mass"
RLY_MNEMONIC_1="record gift you once hip style during joke field prize dust unique length more pencil transfer quit train device arrive energy sort steak upset"

P2PPORT_1=26656
RPCPORT_1=26657
RPCAPPPORT_1=26658
RESTPORT_1=1316
ROSETTA_1=8080

GRPCPORT_1=8090
GRPCWEB_1=8091

TRACE=""
LOGLEVEL="info"

echo "Starting $CHAINID_1 in $CHAIN_DIR..."
echo "Creating log file at $CHAIN_DIR/$CHAINID_1.log"
$BINARY_1 start $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0auptick \
--json-rpc.api eth,txpool,personal,net,debug,web3 \
--log_format json --home $CHAIN_DIR/$CHAINID_1 \
--pruning=nothing --grpc.address="0.0.0.0:$GRPCPORT_1" \
--grpc-web.address="0.0.0.0:$GRPCWEB_1" > $CHAIN_DIR/$CHAINID_1.log 2>&1 &