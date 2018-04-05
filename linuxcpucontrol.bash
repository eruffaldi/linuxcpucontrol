function setgov ()
{
	count = $(grep -c ^processor /proc/cpuinfo)
	count = $(($count-1))
     for i in {0..$count}; 
     do 
         cpufreq-set -c $i -g $1; 
     done
}

function setfreq()
{
	count = $(grep -c ^processor /proc/cpuinfo)
	count = $(($count-1))
     for i in {0..$count}; 
     do 
         cpufreq-set -c $i --min $1 --max $2; 
     done
}

