ROOT_DIR:=$(shell pwd | sed 's/ /\\ /g')

.PHONY: build

help:
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  build 				build the docker container'
	@echo '  run				run afl in the docker container'
	@echo '  enter 				enter the docker container'
	@echo '  stop 				stop the docker container'
	@echo '  clean 				stop and clean docker volumes'

build:
	docker-compose up --build --detach

run:
	docker-compose exec afl screen -S afl_running /root/screen.sh

enter:
	docker-compose exec afl /bin/bash

stop:
	docker-compose stop

clean:
	docker-compose down
