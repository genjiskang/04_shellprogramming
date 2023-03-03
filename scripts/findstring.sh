#!/bin/bash

if [ $# -ne 2 ] ; then                 
    echo "Usage : $0 pattern filename"
    exit 1
fi

if grep $1 $2 > /dev/null 2>&1 ; then  
    echo "Special pattern found"
else
    echo "Special pattern not found"
fi