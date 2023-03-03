#!/bin/bash

echo "===================================================="
echo "  (1). who      (2). date     (3). pwd              "
echo "===================================================="

echo "Enter Your Choice(1-3)? : "       
read NUMBER

case $NUMBER in                          
    1) who  ;;
    2) date ;;
    3) pwd  ;;
    *) echo "Error... Try Again" 
       exit 1 ;;
esac