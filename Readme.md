# GrumpPHP wrapped in a Docker container

This container contains [Grumphp](https://github.com/phpro/grumphp)  with some code quality tools that I use in my web projects. 
The container can be used for projects that do not want to have all composer dev dependencies in the project itself.

Another advantage is that the execution time in a CI pipeline is much shorter, since the composer dependencies do not need to be installed.

Currently is contains the following tools
                                              |
* [PHP-CS-Fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer). Fixes your php code to the PSR12 standard.
* [PHP Mess Detector](https://phpmd.org/) It takes a given PHP source code base and look for several 
* [PHPStan](https://github.com/phpstan/phpstan). Discover bugs in your code without running 
* [Psalm](https://github.com/vimeo/psalm). A static analysis tool for finding errors in PHP 
* [PHPUnit](https://phpunit.de/). Units tests
* [TypoScript Lint](https://github.com/martin-helmich/typo3-typoscript-lint). Find coding errors in your TypoScript files.  
* [yamllint](https://yamllint.readthedocs.io/en/stable/). A Linter for YAML files
* [PHP Parallel Lint](https://github.com/php-parallel-lint/PHP-Parallel-Lint). A Linter for PHP files.   
* [Composer Audit](https://getcomposer.org/doc/03-cli.md#audit). This command is used to audit the packages you have installed for possible security issues.

## Usage

The "src" folder contains the code to be checked or analyzed.
The folder ".grumphp" the cofiguration files for the tools you wanna use.

```
root
├── .grumphp
│   ├─ php-cs-fixer.php
│   ├─ phpmd.xml
│   ├─ phpstan.neon
│   ├─ psalm.xml
│   ├─ unittests.xml
│   ├─ typoscript-lint.yaml
├── src
├── grumphp.yaml
├── composer.json
├── composer.lock
```

To run grumphp, execute the following commands in the root directory.

1. Get the docker image from docker hub
```
docker pull madlenka/grumphp-docker
```

2. Run all grumphp tasks defined in your grumphp.yml
```
docker run --rm -it -v $(pwd):/grumphp madlenka/grumphp-docker grumphp run
```

To trigger GrumPHP with the git hooks (e.g. pre-commit), you can configure the "EXEC_GRUMPHP_COMMAND" as follows in your grumphp.yml

```yaml
grumphp:
  git_hook_variables:
    EXEC_GRUMPHP_COMMAND: 'docker run --rm -v $(pwd):/grumphp madlenka/grumphp-docker'
```

After you have set the EXEC_GRUMPHP_COMMAND configuration, you can either run the following command manually in the project directory ...
```
docker run --rm -v $(pwd):/grumphp madlenka/grumphp-docker grumphp git:init
```

... or you can run the command automatically during the Composer installation using the "post-install-cmd" script:
```
"scripts": {
    "post-install-cmd": [
        "docker run --rm -v $(pwd):/grumphp madlenka/grumphp-docker grumphp git:init"
    ]
  }
```

or you can run the command automatically during project startup in development environments like ddev

```yaml
# add the followin configuration to .ddev/config.yaml 
hooks:
  post-start:
    - exec-host: docker run --rm -v $(pwd):/grumphp madlenka/grumphp-docker grumphp git:init
```

To run php-cs-fixer standalone, you can also run it as follows:

```bash
docker run -it --rm -v $(pwd):/grumphp madlenka/grumphp-docker php-cs-fixer fix "src" --config ".grumphp/.php-cs-fixer.php"
```

# Build and test container

## Prepare (Mac)

Install buildx via hombrew

```bash
brew install docker-buildx
```

To build a docker multi-platform image, we need to create a new builder which gives access to the multi-architecture build feature:

```bash
docker buildx create --name builder
docker buildx use builder
```

Check if everthing is ok

```bash
docker buildx inspect --bootstrap
```

## Build, Test and Release

```bash
git clone https://github.com/madikon/grumphp-docker.git
cd grumphp-docker

# Dev build and test
make build-dev-amd
make install
make test

# Build and Release 
make release version=1.0.2
```