PKG_INST_AND_VERIFY() {
PKG=$1
echo "[  **  ] Installing packages - $PKG"
yum -q -y install $PKG >/dev/null 2>&1
rpm -q $PKG >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[  OK  ] The package($PKG) has been installed."
else
    echo "[ FAIL ] The package($PKG) not installed."
    exit 1
fi
}

SVC_ENABLE_AND_START() {
SVC=$1
echo "[  **  ] Enable service - $SVC"
systemctl enable $SVC >/dev/null 2>&1
ENABLE_STATUS=$(systemctl is-enabled $SVC)
systemctl restart $SVC >/dev/null 2>&1
START_STATUS=$(systemctl is-active $SVC)
if [ $ENABLE_STATUS = enabled -a $START_STATUS = active ] ; then
    echo "[  OK  ] The service($SVC) was started normally."
else
    echo "[ FAIL ] The service($SVC) has not been started."
    exit 2
fi
}

ADD_SVC_FW() {
FW_SVC=$1
echo "[  **  ] Configuring firewall"
FW_STATUS=$(systemctl is-active firewalld)
if [ $FW_STATUS = 'active' ] ; then
    firewall-cmd --permanent --add-service $FW_SVC >/dev/null 2>&1
    firewall-cmd --reload >/dev/null 2>&1
    echo "[  OK  ] The telnet service is registered on the firewall."
else
    echo "[ INFO ] Firewall service is not enabled."
fi
}

function print_good () {
    echo -e "\x1B[01;32m[+]\x1B[0m $1"
}

function print_error () {
    echo -e "\x1B[01;31m[-]\x1B[0m $1"
}

function print_info () {
    echo -e "\x1B[01;34m[*]\x1B[0m $1"
}
