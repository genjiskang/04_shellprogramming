#!/bin/bash

while true
do
    echo -n "ftp> "
    read CMD
    case $CMD in
        'quit'|'bye')
        'help')
        *)
    easc
done