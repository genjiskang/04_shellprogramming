#!/bin/bash

echo -n "Enter A : "
read A1

echo -n "Enter Operator : "
read B1

echo -n "Enter C : "
read C1

case $B1 in
        '+') echo "$A1 + $C1 = $(expr $A1 + $C1)"  ;;
        '-') echo "$A1 - $C1 = $(expr $A1 - $C1)"  ;;
        '*') echo "$A1 x $C1 = $(expr $A1 \* $C1)" ;;
        '/') echo "$A1 / $C1 = $(expr $A1 / $C1)"  ;;
        *) echo "Error"
       exit 1
esac