#!/bin/bash

NUM=1

echo -ne "50% 다운받는 중 | "

while [ $NUM -le 5 ]
do
    echo -ne "="
    sleep 1
    NUM=`expr $NUM + 1`
done
echo -ne '>\n'