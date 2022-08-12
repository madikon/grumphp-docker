# GrumpPHP wrapped in a Docker container

This container contains [Grumphp](https://github.com/phpro/grumphp)  with some code quality tools that I use in my web projects. 
The container can be used for projects that do not want to have all composer dev dependencies in the project itself.

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
* [Local PHP Security Checker](https://github.com/fabpot/local-php-security-checker). Checks if your PHP application depends on PHP packages with known security vulnerabilities

## Usage

The "src" folder contains the code to be checked or analyzed.
The folder ".grumphp" the cofiguration files for the tools you wanna use.

```
root
├── .grumphp
│   ├─ php-cs-fixer.php
│   ├─ phplint.yaml
│   ├─ phpmd.xml
│   ├─ phpstan.neon
│   ├─ psalm.xml
│   ├─ unittests.xml
│   ├─ typoscript-lint.yaml
│   ├─ yamlintl.yaml
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
# Build and test container

## Build Dev

```bash
git clone https://github.com/madikon/grumphp-docker.git
cd grumphp-docker

# Dev build
make build-dev

# Release build 
make build version=1.0.0
```

## Test 

```bash
make install 
make test
```

## Push 

```bash
make push version=1.0.0
```





