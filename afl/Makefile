ROOT_DIR:=$(shell pwd | sed 's/ /\\ /g')

.PHONY: build

help:
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  run 				run the already build docker container'
	@echo '  build 				build the docker container'
	@echo '  enter 				enter the docker container'
	@echo '  stop 				stop the docker container'
	@echo '  clean 				stop and clean docker volumes'

run:
	docker-compose up --detach

build:
	docker-compose up --build --detach

enter:
	docker-compose exec afl /bin/bash

stop:
	docker-compose stop

clean:
	docker-compose down
