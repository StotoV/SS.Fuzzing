#!/bin/bash
echo core > /proc/sys/kernel/core_pattern
cd /sys/devices/system/cpu && echo performance | tee cpu*/cpufreq/scaling_governor

NOW=$(date +'%Y-%m-%d_%H:%M:%S')
SLAVES=${SLAVES:-0}
OPTIONS=${OPTIONS:-}
echo "$SLAVES slaves to be created"

mkdir /root/results/$NOW
echo "Results dir created ($NOW)"

afl-fuzz -M master -m none -i /root/testcases -o /root/results/$NOW -- /root/bin/ffmpeg &
echo "Master instance running"

i=1
while [ "$i" -le "$SLAVES" ]; do
    afl-fuzz -S slave_$i -m none -i /root/testcases -o /root/results/$NOW -- /root/bin/ffmpeg &
    echo "Slave instance running"
    i=$(($i + 1))
done

while true
do
	# echo "Press [CTRL+C] to stop.."
	sleep 1
done
