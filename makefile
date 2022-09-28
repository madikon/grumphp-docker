ARGS = $(filter-out $@,$(MAKECMDGOALS))
VERSION='1.0.1'
FABOT_SECURITY_CHECKER_VERSION=2.0.4
PHP_VERSION=8.1

.PHONY: list build-dev build push install test

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

install:
	composer install -d ./test

build-dev:
	docker buildx build --platform linux/arm64/v8 --load --force-rm --no-cache -t madlenka/grumphp-docker \
		--build-arg=PHP_VERSION=$(PHP_VERSION) \
		--build-arg=FABOT_SECURITY_CHECKER_VERSION=$(FABOT_SECURITY_CHECKER_VERSION) docker/

test:
	docker run --rm -it -v $$(pwd):/grumphp madlenka/grumphp-docker grumphp run

ssh:
	docker run --rm -it -v $$(pwd):/grumphp madlenka/grumphp-docker /bin/sh

release: 
	@echo "Building madlenka/grumphp-docker:latest and madlenka/grumphp-docker:$(version)"
	docker buildx build --push --platform linux/amd64,linux/arm64/v8 \
		--build-arg=PHP_VERSION=$(PHP_VERSION) \
		--build-arg=FABOT_SECURITY_CHECKER_VERSION=$(FABOT_SECURITY_CHECKER_VERSION) \
		--tag madlenka/grumphp-docker:latest \
		--tag madlenka/grumphp-docker:$(VERSION) \
		 docker/