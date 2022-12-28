#!/bin/bash

DAEMON_HOME=/Users/xuxinlai/my/mul/work/new/uptick-test/data/uptick_7000-1/
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"

# 给提案质押
uptickd tx gov submit-proposal software-upgrade v0.2.3 \
--deposit 20000000auptick \
--title upgrade --description upgrade --upgrade-height 20 \
--from $valWallet --yes --keyring-backend test --keyring-dir $DAEMON_HOME \
--chain-id uptick_7000-1 -b block \
 --node tcp://127.0.0.1:26657 -y
