#!/bin/bash

# NAME: set-hyper-threading
# PATH: /usr/local/bin
# DESC: Turn Hyper threading off or on.

# DATE: Aug. 5, 2017.

# NOTE: Written Part of testing for Ubuntu answer:
#       https://askubuntu.com/questions/942728/disable-hyper-threading-in-ubuntu/942843#942843

# PARM: 1="0" turn off hyper threading, "1" turn it on.

if [[ $# -ne 1 ]]; then
    echo 'One argument required. 0 to turn off hyper-threading or'
    echo '1 to turn hyper-threading back on'
    exit 1
fi
#Active CORE ONLY
#count=$(grep -c ^processor /proc/cpuinfo)
if [[ $1 -ne 1 ]]; then
echo "disabling"
for (( i=1; i<100; i+=2 )); 
do 
if [ -d /sys/devices/system/cpu/cpu$i ]; then
echo 0  > /sys/devices/system/cpu/cpu$i/online
else
break
fi
done
else
echo "enabling"
for (( i=0; i<100; i+=1 ));
do
if [ -d /sys/devices/system/cpu/cpu$i ]; then
echo "enabling $i"
echo 1 > /sys/devices/system/cpu/cpu$i/online
else
break
fi
done
fi

grep "" /sys/devices/system/cpu/cpu*/topology/core_id

grep -q '^flags.*[[:space:]]ht[[:space:]]' /proc/cpuinfo && \
    echo "Hyper-threading is supported"

grep -E 'model|stepping' /proc/cpuinfo | sort -u

echo "CPUs $(grep -c ^processor /proc/cpuinfo)" 

