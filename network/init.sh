#!/bin/bash


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

##chain2 test-2
BINARY_2=nftd
CHAINID_2=test-2

VAL_MNEMONIC_2="angry twist harsh drastic left brass behave host shove marriage fall update business leg direct reward object ugly security warm tuna model broccoli choice"
DEMO_MNEMONIC_2="veteran try aware erosion drink dance decade comic dawn museum release episode original list ability owner size tuition surface ceiling depth seminar capable only"
RLY_MNEMONIC_2="alley afraid soup fall idea toss can goose become valve initial strong forward bright dish figure check leopard decide warfare hub unusual join cart"

P2PPORT_2=26656
RPCPORT_2=26657
RPCAPPPORT_2=26658
RESTPORT_2=1317
ROSETTA_2=8081

# Stop if it is already running 
## chain1
if pgrep -x "$BINARY_1" >/dev/null; then
    echo "Terminating $BINARY_1..."
    killall $BINARY_1
fi

## chain2
if pgrep -x "$BINARY_2" >/dev/null; then
    echo "Terminating $BINARY_2..."
    killall $BINARY_2
fi

# S"Removing previous data..
echo "Removing previous data..."
rm -rf $CHAIN_DIR/$CHAINID_1 &> /dev/null
rm -rf $CHAIN_DIR/$CHAINID_2 &> /dev/null

# Add directories for both chains, exit if an error occurs
if ! mkdir -p $CHAIN_DIR/$CHAINID_1 2>/dev/null; then
    echo "Failed to create chain folder. Aborting..."
    exit 1
fi

if ! mkdir -p $CHAIN_DIR/$CHAINID_2 2>/dev/null; then
    echo "Failed to create chain folder. Aborting..."
    exit 1
fi

echo "Initializing $CHAINID_1..."
echo "Initializing $CHAINID_2..."

$BINARY_1 init test --home $CHAIN_DIR/$CHAINID_1 --chain-id=$CHAINID_1

# Change parameter token denominations to auptick
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["max_deposit_period"]="60s"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["gov"]["voting_params"]["voting_period"]="60s"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json
cat $CHAIN_DIR/$CHAINID_1/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="auptick"' >$CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json && mv $CHAIN_DIR/$CHAINID_1/config/tmp_genesis.json $CHAIN_DIR/$CHAINID_1/config/genesis.json


$BINARY_2 init test --home $CHAIN_DIR/$CHAINID_2 --chain-id=$CHAINID_2

echo "Adding genesis accounts..."
echo $VAL_MNEMONIC_1  | $BINARY_1 keys add val1 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test
echo $VAL_MNEMONIC_2  | $BINARY_2 keys add val2 --home $CHAIN_DIR/$CHAINID_2 --recover --keyring-backend=test
echo $DEMO_MNEMONIC_1 | $BINARY_1 keys add demowallet1 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test
echo $DEMO_MNEMONIC_2 | $BINARY_2 keys add demowallet2 --home $CHAIN_DIR/$CHAINID_2 --recover --keyring-backend=test
echo $RLY_MNEMONIC_1  | $BINARY_1 keys add rly1 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test 
echo $RLY_MNEMONIC_2  | $BINARY_2 keys add rly2 --home $CHAIN_DIR/$CHAINID_2 --recover --keyring-backend=test


$BINARY_1 add-genesis-account $($BINARY_1 --home $CHAIN_DIR/$CHAINID_1 keys show val1 --keyring-backend test -a) 100000000000000000000000000auptick  --home $CHAIN_DIR/$CHAINID_1
$BINARY_2 add-genesis-account $($BINARY_2 --home $CHAIN_DIR/$CHAINID_2 keys show val2 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_2
$BINARY_1 add-genesis-account $($BINARY_1 --home $CHAIN_DIR/$CHAINID_1 keys show demowallet1 --keyring-backend test -a) 100000000000000000000000000auptick  --home $CHAIN_DIR/$CHAINID_1
$BINARY_2 add-genesis-account $($BINARY_2 --home $CHAIN_DIR/$CHAINID_2 keys show demowallet2 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_2
$BINARY_1 add-genesis-account $($BINARY_1 --home $CHAIN_DIR/$CHAINID_1 keys show rly1 --keyring-backend test -a) 100000000000000000000000000auptick  --home $CHAIN_DIR/$CHAINID_1
$BINARY_2 add-genesis-account $($BINARY_2 --home $CHAIN_DIR/$CHAINID_2 keys show rly2 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_2

echo "Creating and collecting gentx..."
$BINARY_1 gentx val1 70000000000000000000000000auptick --home $CHAIN_DIR/$CHAINID_1 --chain-id $CHAINID_1 --keyring-backend test
$BINARY_2 gentx val2 7000000000stake --home $CHAIN_DIR/$CHAINID_2 --chain-id $CHAINID_2 --keyring-backend test
$BINARY_1 collect-gentxs --home $CHAIN_DIR/$CHAINID_1
$BINARY_2 collect-gentxs --home $CHAIN_DIR/$CHAINID_2

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

sed -i -e 's#"tcp://0.0.0.0:26656"#"tcp://0.0.0.0:'"$P2PPORT_2"'"#g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's#"tcp://127.0.0.1:26657"#"tcp://127.0.0.1:'"$RPCPORT_2"'"#g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's#"tcp://127.0.0.1:26658"#"tcp://127.0.0.1:'"$RPCAPPPORT_2"'"#g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's/timeout-commit = "5s"/timeout_commit = "1s"/g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's/timeout_propose = "3s"/timeout_propose = "1s"/g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's/index_all_keys = false/index_all_keys = true/g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's/mode = "full"/mode = "validator"/g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's/enable = false/enable = true/g' $CHAIN_DIR/$CHAINID_2/config/app.toml
sed -i -e 's/swagger = false/swagger = true/g' $CHAIN_DIR/$CHAINID_2/config/app.toml
sed -i -e 's#"tcp://0.0.0.0:1317"#"tcp://0.0.0.0:'"$RESTPORT_2"'"#g' $CHAIN_DIR/$CHAINID_2/config/app.toml
#sed -i -e 's#":8080"#":'"$ROSETTA_2"'"#g' $CHAIN_DIR/$CHAINID_2/config/app.toml
sed -i -e "$(cat -n $CHAIN_DIR/$CHAINID_2/config/app.toml | grep '\[rosetta\]' -A3 | grep "enable =" | awk '{print $1}')s/enable = true/enable = false/" $CHAIN_DIR/$CHAINID_2/config/app.toml

