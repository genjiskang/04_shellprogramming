#!/bin/bash

for i in $(seq 5)
do 
    # echo "*"
    for j in $(seq $i)
    do
        echo -n "*"
    done
    echo 
done