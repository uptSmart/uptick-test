#!/bin/bash

DAEMON_HOME=/Users/xuxinlai/my/mul/work/new/uptick-test/data/uptick_7000-1/
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"

# voteParam
uptickd tx gov submit-legacy-proposal \
param-change \
proposal/voteParam.json \
--from $valWallet --yes --keyring-backend test --keyring-dir $DAEMON_HOME \
--chain-id uptick_7000-1 -b block \
 --node tcp://127.0.0.1:16657 -y

