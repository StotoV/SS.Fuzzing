.PHONY: build

help:
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  build 				build the docker image that contains the test environment'
	@echo '  clean 				remove the docker images created'
	@echo '  inspect 			enter the docker test image'

build:
	docker-compose up --build

inspect:
	docker-compose exec linux /bin/sh

clean:
	docker-compose down
