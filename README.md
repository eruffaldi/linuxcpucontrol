
# Readme

- hyperthreadig on/off
- turboboost on/off
- frequency control (kind of)


 sudo apt-get install cpufrequtils msr-tools


## cpusets
	
Setup isolating 1 from rest
```
 allcpus=$( ls -l /sys/devices/system/cpu | grep -E "cpu[0-9]+" | wc -l )
 allcpus0=$(($allcpus-1))
 mkdir /dev/cpuset
 mount -t cpuset none /dev/cpuset
 cd /dev/cpuset
 mkdir core1
 mkdir rest
 mkdir all
 /bin/echo 0 > all/cpuset.mems
 /bin/echo 0 > core1/cpuset.mems
 /bin/echo 0 > rest/cpuset.mems
 /bin/echo 0 > core1/cpuset.cpus
 /bin/echo 1 > core1/cpuset.cpu_exclusive
 /bin/echo 1-11 > rest/cpuset.cpus
 /bin/echo $$ > rest/tasks
 cat /proc/self/cpuset

 /bin/echo 0 > core1/cpuset.cpu_exclusive
 /bin/echo 1-$allcpus0 > all/cpuset.cpus
```

Then move all existing tasks to cpuset core1 using all2cpuset.sh
```
   for i in `ps -eLfad |awk '{ print $4 } '|grep -v PID | xargs echo `; do 
	   /bin/echo $i > /dev/cpuset/$1/tasks
	done
```
# Old Notes 

## Prevent Scheduler using CPU

Use isolcpu at boot using kernl then assign manually, can do it at runtime? 

MAYBE check
https://www.kernel.org/doc/Documentation/cgroup-v1/cpusets.txt
https://bbs.archlinux.org/viewtopic.php?id=224352
http://wiki.simwb.com/swbwiki/swbdoc/UserManualFlash/SimConfig/optimizing/optimizing.htm

## Kernel Option
isolcpus=   [KNL,SMP] Isolate CPUs from the general scheduler.
            Format:
            <cpu number>,...,<cpu number>
            or
            <cpu number>-<cpu number>
            (must be a positive range in ascending order)
            or a mixture
            <cpu number>,...,<cpu number>-<cpu number>

        This option can be used to specify one or more CPUs
        to isolate from the general SMP balancing and scheduling
        algorithms. You can move a process onto or off an
        "isolated" CPU via the CPU affinity syscalls or cpuset.
        <cpu number> begins at 0 and the maximum value is
        "number of CPUs in system - 1".

        This option is the preferred way to isolate CPUs. The
        alternative -- manually setting the CPU mask of all
        tasks in the system -- can cause problems and
        suboptimal load balancer performance.

maxcpus=        [SMP] Maximum number of processors that an SMP kernel
                        will bring up during bootup.  maxcpus=n : n >= 0 limits
                        the kernel to bring up 'n' processors. Surely after
                        bootup you can bring up the other plugged cpu by executing
                        "echo 1 > /sys/devices/system/cpu/cpuX/online". So maxcpus
                        only takes effect during system bootup.
                        While n=0 is a special case, it is equivalent to "nosmp",
                        which also disables the IO APIC.

# References
Hyperthread modified from 
https://askubuntu.com/questions/942728/disable-hyper-threading-in-ubuntu
