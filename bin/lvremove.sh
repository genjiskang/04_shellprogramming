#!/bin/bash

lvremove -f /dev/vg1/lv1
vgremove /dev/vg1
pvremove /dev/pv1