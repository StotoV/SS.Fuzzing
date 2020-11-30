#!/bin/bash
NOW=$(date +'%Y-%m-%d_%H:%M:%S')

mkdir /root/results/$NOW
mkdir /root/results/$NOW/cases

for file in /root/testcases/*; do 
    if [ -f "$file" ]; then 
        FILENAME=$(basename "$file" .mp4)

        for ((i=0;i<=1000;i++))
        do
                mkdir /root/results/$NOW/cases/$i
                radamsa -o /root/results/$NOW/cases/$i/test-$FILENAME-$i.mp4 -n 1 /root/testcases/$FILENAME.mp4
                ffmpeg -i /root/results/$NOW/cases/$i/test-$FILENAME-$i.mp4 /root/results/$NOW/cases/$i/output-$FILENAME-$i.avi 2>> /root/results/$NOW/cases/$i/output-$FILENAME-$i.txt
        done
    fi 
done

grep -rnw /root/results/$NOW/cases  -e "moov atom not found" | wc -l 2>> /root/results/$NOW/error.txt
grep -rnw /root/results/$NOW/cases -e "Could not find codec parameters for stream" | wc -l 2>> /root/results/$NOW/warnings.txt
