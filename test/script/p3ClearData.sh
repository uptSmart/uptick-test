#!/bin/bash

if pgrep -x "uptickd" > /dev/null
then
    killall uptickd
fi

rm -rf ./data/*
