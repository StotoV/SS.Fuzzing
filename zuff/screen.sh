#!/bin/bash
NOW=$(date +'%Y-%m-%d_%H:%M:%S')

mkdir /root/results/$NOW
FILENAME=$1

for ((i=0;i<1000;i++))
do
        x=$[10000 + (RANDOM % 10000)]
        x=0.0${x:1:2}${x:3:4}
        zzuf -vq -s $i -r $x < /root/testcases/$FILENAME.mp4 > /root/results/$NOW/$FILENAME${i}_$x.mp4
        ffmpeg -y -i /root/results/$NOW/$FILENAME${i}_$x.mp4 /root/results/$NOW/$FILENAME${i}_$x.avi 2>> /root/results/$NOW/$FILENAME${i}_$x.txt
done
