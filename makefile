ARGS = $(filter-out $@,$(MAKECMDGOALS))
VERSION='1.0.4'
PHP_VERSION=8.2

.PHONY: list build-dev-arm build-dev-amd build push install test

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

install:
	composer install -d ./test

build-dev-amd:
	docker buildx build --platform linux/amd64 --load --force-rm --no-cache -t madlenka/grumphp-docker \
		--build-arg=PHP_VERSION=$(PHP_VERSION) docker/

build-dev-arm:
	docker buildx build --platform linux/arm64/v8 --load --force-rm --no-cache -t madlenka/grumphp-docker \
		--build-arg=PHP_VERSION=$(PHP_VERSION) docker/

test:
	docker run --rm -it -v $$(pwd):/grumphp madlenka/grumphp-docker grumphp run -vvv

ssh:
	docker run --rm -it -v $$(pwd):/grumphp madlenka/grumphp-docker /bin/sh

release: 
	@echo "Building madlenka/grumphp-docker:latest and madlenka/grumphp-docker:$(version)"
	docker buildx build --push --platform linux/amd64,linux/arm64/v8 \
		--build-arg=PHP_VERSION=$(PHP_VERSION) \
		--tag madlenka/grumphp-docker:latest \
		--tag madlenka/grumphp-docker:$(PHP_VERSION)-$(VERSION) \
		 docker/