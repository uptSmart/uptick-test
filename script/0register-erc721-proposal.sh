#!/bin/bash

#0x7c4663d780EfA75dAF623a4E79D505df8be88CDC
#uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"

echo "regest erc721 contract : $1"

uptickd tx gov submit-legacy-proposal register-erc721 $1 \
--deposit 20000000auptick \
--title "regest erc721 " \
--description "regest erc721 for local test" \
--from $valWallet --chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 --gas auto \
--keyring-backend=test -b block --node tcp://127.0.0.1:26657 -y
