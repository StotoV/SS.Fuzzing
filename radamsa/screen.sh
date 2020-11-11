#!/bin/bash
NOW=$(date +'%Y-%m-%d_%H:%M:%S')

mkdir /root/results/$NOW
radamsa -i /root/results/small_movie%.mp4 -n 3 /root/testcases/small_movie.mp4
ffmpeg -i /root/results/small_movie1.mp4
ffmpeg -i /root/results/small_movie2.mp4
ffmpeg -i /root/results/small_movie3.mp4
