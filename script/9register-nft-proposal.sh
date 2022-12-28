#!/bin/bash
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"

uptickd tx gov submit-legacy-proposal register-nft ./proposal/nftErc721Pair.json \
--deposit 20000000auptick \
--title "regest nft " \
--description "regest nft for local test" \
--from $valWallet --chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 --gas auto \
--keyring-backend=test -b block --node tcp://127.0.0.1:26657 -y
