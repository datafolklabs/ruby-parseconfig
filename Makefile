.PHONY: dev test docker docker-push

dev:
	docker-compose up -d
	docker-compose exec parseconfig /bin/bash

test:
	./utils/run-tests.sh
