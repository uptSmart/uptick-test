#!/bin/bash

killall uptickd

#chain params 
CHAIN_DIR=./data

##chain1 uptick
BINARY_1=uptickd
CHAINID_1=uptick_7000-1

VAL_MNEMONIC_1="clock post desk civil pottery foster expand merit dash seminar song memory figure uniform spice circle try happy obvious trash crime hybrid hood cushion"
DEMO_MNEMONIC_1="banner spread envelope side kite person disagree path silver will brother under couch edit food venture squirrel civil budget number acquire point work mass"
RLY_MNEMONIC_1="record gift you once hip style during joke field prize dust unique length more pencil transfer quit train device arrive energy sort steak upset"

P2PPORT_1=16656
RPCPORT_1=16657
RPCAPPPORT_1=16658
RESTPORT_1=1316
ROSETTA_1=8080

GRPCPORT_1=8090
GRPCWEB_1=8091

TRACE=""
LOGLEVEL="info"

DAEMON_NAME=uptickd
DAEMON_HOME=/Users/xuxinlai/my/mul/work/new/uptick-test/data/uptick_7000-1/
DAEMON_RESTART_AFTER_UPGRADE=true

# Stop if it is already running 
## chain1
if pgrep -x "$BINARY_1" >/dev/null; then
    echo "Terminating $BINARY_1..."
    killall $BINARY_1
fi

# S"Removing previous data..
echo "Removing previous data..."
rm -rf $CHAIN_DIR/$CHAINID_1 &> /dev/null

# Add directories for both chains, exit if an error occurs
if ! mkdir -p $CHAIN_DIR/$CHAINID_1 2>/dev/null; then
    echo "Failed to create chain folder. Aborting..."
    exit 1
fi


echo "Initializing $CHAINID_1..."

$BINARY_1 init test --home $CHAIN_DIR/$CHAINID_1 --chain-id=$CHAINID_1

# Change parameter token denominations to auptick
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["max_deposit_period"]="60s"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["gov"]["voting_params"]["voting_period"]="60s"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json

echo "Adding genesis accounts..."
echo $VAL_MNEMONIC_1  | $BINARY_1 keys add val1 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test
echo $DEMO_MNEMONIC_1 | $BINARY_1 keys add demowallet1 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test
echo $RLY_MNEMONIC_1  | $BINARY_1 keys add rly1 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test 

$BINARY_1 add-genesis-account $($BINARY_1 --home $CHAIN_DIR/$CHAINID_1 keys show val1 --keyring-backend test -a) 100000000000000000000000000auptick  --home $CHAIN_DIR/$CHAINID_1
$BINARY_1 add-genesis-account $($BINARY_1 --home $CHAIN_DIR/$CHAINID_1 keys show demowallet1 --keyring-backend test -a) 100000000000000000000000000auptick  --home $CHAIN_DIR/$CHAINID_1
$BINARY_1 add-genesis-account $($BINARY_1 --home $CHAIN_DIR/$CHAINID_1 keys show rly1 --keyring-backend test -a) 100000000000000000000000000auptick  --home $CHAIN_DIR/$CHAINID_1

echo "Creating and collecting gentx..."
$BINARY_1 gentx val1 70000000000000000000000000auptick --home $CHAIN_DIR/$CHAINID_1 --chain-id $CHAINID_1 --keyring-backend test
$BINARY_1 collect-gentxs --home $CHAIN_DIR/$CHAINID_1

echo "Changing defaults and ports in app.toml and config.toml files..."
sed -i -e 's#"tcp://0.0.0.0:26656"#"tcp://0.0.0.0:'"$P2PPORT_1"'"#g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's#"tcp://127.0.0.1:26657"#"tcp://127.0.0.1:'"$RPCPORT_1"'"#g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's#"tcp://127.0.0.1:26658"#"tcp://127.0.0.1:'"$RPCAPPPORT_1"'"#g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's/timeout-commit = "5s"/timeout_commit = "1s"/g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's/timeout-propose = "3s"/timeout_propose = "1s"/g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's/index_all_keys = false/index_all_keys = true/g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's/mode = "full"/mode = "validator"/g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's/enable = false/enable = true/g' $CHAIN_DIR/$CHAINID_1/config/app.toml
sed -i -e 's/swagger = false/swagger = true/g' $CHAIN_DIR/$CHAINID_1/config/app.toml
sed -i -e 's#"tcp://0.0.0.0:1317"#"tcp://0.0.0.0:'"$RESTPORT_1"'"#g' $CHAIN_DIR/$CHAINID_1/config/app.toml
#sed -i -e 's#":8080"#":'"$ROSETTA_1"'"#g' $CHAIN_DIR/$CHAINID_1/config/app.toml
sed -i -e "$(cat -n $CHAIN_DIR/$CHAINID_1/config/app.toml | grep '\[rosetta\]' -A3 | grep "enable =" | awk '{print $1}')s/enable = true/enable = false/" $CHAIN_DIR/$CHAINID_1/config/app.toml


echo "Starting $CHAINID_1 in $CHAIN_DIR..."
echo "Creating log file at $CHAIN_DIR/$CHAINID_1.log"

# $BINARY_1 start $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0auptick \
# --gas-prices="0.025auptick" \
# --json-rpc.api eth,txpool,personal,net,debug,web3 \
# --log_format json --home $CHAIN_DIR/$CHAINID_1 \
# --pruning=nothing --grpc.address="0.0.0.0:$GRPCPORT_1" \
# --grpc-web.address="0.0.0.0:$GRPCWEB_1" > $CHAIN_DIR/$CHAINID_1.log 2>&1 &

cp -rp cosmovisor data/uptick_7000-1/


cosmovisor run start $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0auptick \
--json-rpc.api eth,txpool,personal,net,debug,web3 \
--log_format json --home $CHAIN_DIR/$CHAINID_1 \
--pruning=nothing --grpc.address="0.0.0.0:$GRPCPORT_1" \
--grpc-web.address="0.0.0.0:$GRPCWEB_1" > $CHAIN_DIR/$CHAINID_1.log 2>&1 &

# uptickd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001auptick --json-rpc.api eth,txpool,personal,net,debug,web3
# uptickd start --pruning=nothing --minimum-gas-prices=0.0001auptick --json-rpc.api eth,txpool,personal,net,debug,web3 --home data/uptick_7000-1

# sleep 6

# uptickd tx bank send uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d uptick1p4szayprev5yml5f2l6uq39gyuzamq3j9kqr2a \
# 1000000000auptick --chain-id uptick_7000-1 --home ./data/uptick_7000-1 \
# --node tcp://localhost:16657 --keyring-backend test -y

# uptickd tx bank send uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d uptick17d0c8nedfzlytj0kcs80rh3fk8el58fvnw8pmw \
# 11000000000000000000auptick --chain-id uptick_7000-1 --home ./data/uptick_7000-1 \
# --node tcp://localhost:16657 --keyring-backend test -y ;