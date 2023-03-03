#!/bin/bash 
# ftp 서버
# 환경설정 $HOME/.bashrc

cat << EOF >> $BASHRC

#!/bin/bash

# (1) Package Installation
# (2) Service Enable/Start
# (3) Service Configuration
# (4) Firewall Configuration
# (5) SELinux Configuration

TELNET_PKG="telnet-server telnet"
TELNET_SVC="telnet.socket"
TELNET_CONF="/etc/securetty"
FW_TELNET_SVC="telnet"

. functions.sh

########################### TELNET SERVICE #############################
# (1) Package Installation - telnet, telnet-server
PKG_INST_AND_VERIFY "$TELNET_PKG"

# (2) Service Enable/Start
SVC_ENABLE_AND_START "$TELNET_SVC"

# (3) Service Configuration
echo "[  **  ] Configuring telnet serivce."
grep -q 'pts/' $TELNET_CONF
if [ $? -ne 0 ] ; then
    for i in $(seq 0 11)
    do
        echo "pts/$i" >> $TELNET_CONF
    done
fi
echo "[  OK  ] Telnet service has been set up."

# (4) Firewall Configuration
ADD_SVC_FW "FW_TELNET_SVC"

# (5) SELinux Configuration