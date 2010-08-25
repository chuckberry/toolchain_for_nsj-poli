#!/bin/awk
#
# this script calculate scheduling latency of task given in input
# according to trace file generated by sched_switch tracer


BEGIN {

	# 0: running
	# 1: sleeping
	taskstate = 1
	len = 0;
	str = 0;

	last_cpu = -1
	nr_migration = 0;

	n = 0;
	print "#list of exec. time"
}

$NF == task && $0 ~ /+/ {

	# wake up string

	#task is entering
	if(taskstate == 0) {
		print "ERROR: " task " was already waken..."
		next
	}
	
	#printf("##%s entering.. ",task)
	taskstate = 0
	len=match($3,":");
	timestamp1=substr($3,0,len-1);
	#printf ("##%.06f\n", timestamp1)
}

$NF == task && $0 ~ /==>/ {
	#task is leaving
	if(taskstate == 1) {
		print "ERROR: " task " already sleeping..."
		next
	}
	taskstate = 1
	len=match($3,":");
	timestamp2=substr($3,0,len-1);

	exec_time=timestamp2-timestamp1
	exec_time*=1000000
	printf("%.0f %.06f\n", exec_time,timestamp2);
	n++
}


