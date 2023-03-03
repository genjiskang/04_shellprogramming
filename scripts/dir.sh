#!/bin/bash

echo "Enter Your Filename ? : "
read FILE1

if [ -d $FILE1 ] ; then
    echo "File is a Directory."
elif [ -f $FILE1 ] ; then
    echo "File is a regular file."
else
    echo "Not Found."
fi