#!/bin/bash
NOW=$(date +'%Y-%m-%d_%H:%M:%S')

mkdir /root/results/$NOW
afl-fuzz -m none -i /root/testcases -o /root/results/$NOW -- /root/bin/ffmpeg
