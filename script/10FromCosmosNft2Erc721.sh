#!/bin/bash
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"

uptickd tx erc721 convert-nft "0x49860A6772c1DB9F8fE9E5e2aa725Fdec498d699" \
--from $valWallet --chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 --gas auto \
--keyring-backend=test -b block --node tcp://127.0.0.1:26657 -y
