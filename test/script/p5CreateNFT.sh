#!/bin/bash

valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"

uptickd tx nft mint cdemon2 uptick2 \
--name=name1 --uri=uri1 --data=data1 --uri-hash=uriHash1 \
--from $valWallet --chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 --gas auto \
--keyring-backend=test -b block --node tcp://127.0.0.1:26657 -y
