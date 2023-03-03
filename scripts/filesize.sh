#!/bin/bash

if [ $# -ne 1 ] ; then
    echo "Usage : $0 filename"
    exit 1
fi

FILESIZE=`wc -c < $1`

if [ "$FILESIZE" -le 5120 ] ; then
    echo "This file($1) is a small file"
else
    echo "This file($1) is a big file"
fi