#!/bin/bash
NOW=$(date +'%Y-%m-%d_%H:%M:%S')

mkdir /root/results/$NOW
mkdir /root/results/$NOW/cases
FILENAME=$1

for ((i=0;i<=1000;i++))
do
        radamsa -o /root/results/$NOW/test$i.mp4 -n 1 /root/testcases/$FILENAME
        ffmpeg -i /root/results/$NOW/test$i.mp4 /root/results/$NOW/cases/output$i.avi 2>> /root/results/$NOW/cases/output$i.txt
done

grep -rnw /root/results/$NOW/cases  -e "moov atom not found" | wc -l 2>> /root/results/$NOW/error.txt
grep -rnw /root/results/$NOW/cases -e "Could not find codec parameters for stream" | wc -l 2>> /root/results/$NOW/warnings.txt
