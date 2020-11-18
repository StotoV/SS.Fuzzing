ROOT_DIR:=$(shell pwd | sed 's/ /\\ /g')

.PHONY: build

help:
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  build 				build the docker container'
	@echo '  enter 				enter the docker container'
	@echo '  stop 				stop the docker container'
	@echo '  clean 				stop and clean docker volumes'

build:
	docker-compose up --build --detach

enter:
	docker-compose exec zzuf /bin/bash

stop:
	docker-compose stop

clean:
	docker-compose down
