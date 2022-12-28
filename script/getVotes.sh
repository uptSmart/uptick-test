#!/bin/bash

uptickd query gov votes $1 \
--chain-id uptick_7000-1 \
--node tcp://127.0.0.1:26657
