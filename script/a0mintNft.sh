#!/bin/bash

demowallet1="uptick1ehh5503n2rhpz8evfqpsa62kfqc58c5g02kjhd"

# Issue an nft class
uptickd tx nft issue cat --name xiaopi --symbol pipi \
--description "my cat" --uri "hhahahh"  \
--from $demowallet1 --chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 --fees=1auptick \
--keyring-backend=test -b block --node tcp://127.0.0.1:26657 -y

# Mint a nft
uptickd tx nft mint cat xiaopi --uri="http://wwww.baidu.com" \
--from $demowallet1 --chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 --fees=1auptick \
--keyring-backend=test -b block --node tcp://127.0.0.1:26657 -y
