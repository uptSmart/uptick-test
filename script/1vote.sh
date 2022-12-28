#!/bin/bash

# - address: uptick1ehh5503n2rhpz8evfqpsa62kfqc58c5g02kjhd
#   name: demowallet1
# - address: uptick1z3kehhtkjzdtd8kaz56srtp9e9wh9ywzwdy4w9
#   name: rly1

#0x7c4663d780EfA75dAF623a4E79D505df8be88CDC
#uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"
#valWallet="uptickvaloper103rx84uqa7n4mtmz8f88n4g9m7973rxucm78jp"
# demowallet1="uptick1ehh5503n2rhpz8evfqpsa62kfqc58c5g02kjhd"
# rly1="uptick1z3kehhtkjzdtd8kaz56srtp9e9wh9ywzwdy4w9"

echo "vote id is : $1" 

uptickd tx gov vote $1 yes \
--from $valWallet --chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 \
--keyring-backend=test \
--node tcp://127.0.0.1:26657 --gas auto \
--home ./data/uptick_7000-1 -y
