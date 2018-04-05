#!bin/bash
. ./linuxcpucontrol.bash
setgov performance
setfreq 3.5GHz 3.5GHz
./linuxturbo-boost.sh disable