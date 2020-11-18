# AFL Fuzzing reproduction log

## Specs
Platform: MacOS 10.15.7
Implementation: afl-fuzz 2.56b by <lcamtuf@google.com>, installed with brew
MPV: mpv 0.32.0 built on Tue Jun 16 15:58:50 BST 2020

## Getting started steps
* Recompile MPV with the afl-gcc
make build

* Run smart
make run

* Run dumb
make run_dumb

* Clean
make clean

## Testcases
Can be found in /testcases
