#!/bin/bash

#0x7c4663d780EfA75dAF623a4E79D505df8be88CDC
#uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"

uptickd keys list \
--chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 \
--keyring-backend=test \
--node tcp://127.0.0.1:16657