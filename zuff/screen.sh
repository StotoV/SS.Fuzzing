#!/bin/bash
NOW=$(date +'%Y-%m-%d_%H:%M:%S')

mkdir /root/results/$NOW

while true
do
	echo "Press [CTRL+C] to stop.."
	sleep 1
done
# -i /root/results/small_movie%.mp4 -n 3 /root/testcases/small_movie.mp4
