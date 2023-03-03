#!/bin/bash

echo "Enter Your Choice? (y/n): "
read ANSWER

case $ANSWER in
    yes | Y | Yes | YES | y) echo "Yes... Entered" ;;
    no  | N | No  | NO  | n) echo "No... Entered"  ;;
    *) echo "Answer not recongnize" 
       exit 1 ;;
esac