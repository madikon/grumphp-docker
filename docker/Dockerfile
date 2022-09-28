ARG PHP_VERSION=8.1

FROM php:${PHP_VERSION}-alpine

RUN set -eux; \
    apk --no-cache update && \
    apk --no-cache upgrade

RUN set -eux; \
    apk --no-cache update && \
    apk --no-cache add tzdata git zip libzip-dev && \
    docker-php-ext-install zip && \
    cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    echo "Europe/Berlin" > /etc/timezone

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1

COPY ./composer.json /root/.composer/composer.json 

RUN composer global install

ARG VERSION_FABOT_SECURITY_CHECKER=2.0.4
RUN curl -sSL https://github.com/fabpot/local-php-security-checker/releases/download/v${VERSION_FABOT_SECURITY_CHECKER}/local-php-security-checker_${VERSION_FABOT_SECURITY_CHECKER}_linux_amd64 -o /usr/local/bin/local-php-security-checker && \
    chmod +x /usr/local/bin/local-php-security-checker

ENV PATH=$PATH:/root/.composer/vendor/bin

WORKDIR /grumphp