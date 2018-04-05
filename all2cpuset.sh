#!/bin/bash

for i in `ps -eLfad |awk '{ print $4 } '|grep -v PID | xargs echo `; do 
	/bin/echo $i > /dev/cpuset/$/tasks
done

