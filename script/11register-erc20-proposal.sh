#!/bin/bash

#0x7c4663d780EfA75dAF623a4E79D505df8be88CDC
#uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"

# echo "regest erc721 contract : $1" 

# uptickd tx gov submit-legacy-proposal register-erc721 $1 \
# --deposit 20000000auptick \
# --title "regest erc721 " \
# --description "regest erc721 for local test" \
# --from $valWallet --chain-id uptick_7000-1 \
# --keyring-dir ./data/uptick_7000-1 --gas auto \
# --keyring-backend=test -b block --node tcp://127.0.0.1:16657 -y

uptickd tx gov submit-proposal register-coin proposal/coinPair.json \
--from $valWallet --chain-id uptick_7000-1 -b block -y --gas auto \
--keyring-dir ./data/uptick_7000-1 --gas auto \
--keyring-backend=test -b block  \
--title "Register IBC Denom ATOM For Channel-3" \
--description "Register the ibc denom uatom from channel-3 . denom:ibc/A4DB47A9D3CF9A068D454513891B526702455D3EF08FB9EB558C561F9DC2B701 , channel: channel-3 <-> channel-449 " \
--deposit 10000000000000auptick --node tcp://127.0.0.1:16657