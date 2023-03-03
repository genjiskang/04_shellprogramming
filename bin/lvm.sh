#!/bin/bash

TMP1=/tmp/tm1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3
TMP4=/tmp/tmp4

# 1. PV
# 2. VG
# 3. LV

echo ":: pv 생성 ::"
#######################
# 1. PV
#######################
# (1) View
echo "            "
fdisk -l | grep LVM | awk '{print $1}' > $TMP1
pvs | tail -n +2 | awk '{print $1}' > $TMP2
cat $TMP1 $TMP2 | sort | uniq -u 
echo "       -> PV가 생성되었습니다."

echo "            "
cat << EOF
================ PV VIEW =================
cat $TMP1 $TMP2 | sort | uniq -u
==========================================
EOF

# (2) Works
echo -n "위의 목록에서 PV로 생성하고 싶은 볼륨을 선택합니다. <="
echo -n "볼륨 선택? (ex: /dev/sdb1 /dev/sdc1 ...) : "
read VOLUME

echo "-------------------------------------------------------"
pvcreate $VOLUME >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Physical volume $VOLUME successfully created."
    pvs
else
    echo "[ FAIL ] Physical volume not created."
    exit 1
fi
echo "-------------------------------------------------------"

echo ":: VG 생성 ::"

#######################
# 2. VG
#######################
# (1) View
echo "-------------------------------------------------------"
vgs | tail -n +2 | awk '{print $1}' > $TMP3
pvs > $TMP4
for i in $(cat $TMP3)
do
    sed -i "/$i/d" $TMP4
done 
echo "-------------------------------------------------------"

cat << EOT
================= VG List =================
$(cat $TMP4)
===========================================
EOT

# (2) Works
# vgcreate vg1 /dev/sdb1 /dev/sdc1
echo -n "VG 이름을 적어주세요. (ex: vg1) : "
read VGNAME

echo -n "선택가능한 PV 목록을 적어주세요. (ex: /dev/sdb1 /dev/sdc1 ...) : "
read PVLIST

vgcreate $VGNAME $PVLIST > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Volume group $VGNAME successfully created."
    vgs
else
    echo "[ FAIL ] Volume group not created."
    exit 2
fi

echo "##################### LV 생성 ######################"
#######################
# 3. LV
#######################

# (1) View

cat << EOT
================ LV List =================
$(vgs | awk '$7 != '0' {print $0}')
==========================================
EOT

# (2) Works
# lvcreate vg1 -n lv1 -L 500m
echo -n "LV를 생성할 VG 이름을 적어주세요. (ex: vg1) : "
read VGLV

echo -n "생성할 LV 이름을 적어주세요. (ex: lv1) : "
read LVNAME

echo -n "LV 용량은? (ex: 500m) : "
read LVSIZE

echo "-------------------------------------------------------"
lvcreate $VGLV -n $LVNAME -L $LVSIZE
if [ $? -eq 0 ] ; then
    echo "[ OK ] lOGICAL Volume $LVNAME successfully created."
    lvs
else
    echo "[ FAIL ] Logical Volume not created."
    exit 3
fi
echo "-------------------------------------------------------"