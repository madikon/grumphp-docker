ARGS = $(filter-out $@,$(MAKECMDGOALS))
VERSION='1.0.0'
FABOT_SECURITY_CHECKER_VERSION=2.0.4
PHP_VERSION=8.1

.PHONY: list build-dev build push install test

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

install:
	composer install -d ./test

build-dev:
	docker build --force-rm --no-cache -t madlenka/grumphp-docker \
		--build-arg=PHP_VERSION=$(PHP_VERSION) \
		--build-arg=FABOT_SECURITY_CHECKER_VERSION=$(FABOT_SECURITY_CHECKER_VERSION) docker/

test:
	docker run --rm -it -v $$(pwd):/grumphp madlenka/grumphp-docker grumphp run

ssh:
	docker run --rm -it -v $$(pwd):/grumphp madlenka/grumphp-docker /bin/sh


build: 
	@echo "Building madlenka/grumphp-docker:latest and madlenka/grumphp-docker:$(version)"
	docker build --force-rm --no-cache -t madlenka/grumphp-docker \
		--build-arg=PHP_VERSION=$(PHP_VERSION) \
		--build-arg=FABOT_SECURITY_CHECKER_VERSION=$(FABOT_SECURITY_CHECKER_VERSION) \
		-t madlenka/grumphp-docker:latest \
		-t madlenka/grumphp-docker:$(version) docker/

push:
	@echo "Pushing madlenka/grumphp-docker:latest and madlenka/grumphp-docker:$(version)"
	docker push madlenka/grumphp-docker:latest
	docker push madlenka/grumphp-docker:$(version)