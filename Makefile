ROOT_DIR:=$(shell pwd | sed 's/ /\\ /g')
.PHONY: build

help:
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  build 				build the mpv with the afl compiler'
	@echo '  run				run afl'
	@echo '  clean 				clean out the bin dir'

build:
	${ROOT_DIR}/build_scripts/build_mpv_macos_afl_fuzzing.sh

run:
	afl-fuzz

clean:
	rm -rf ${ROOT_DIR}/bin/
