ARG PHP_VERSION=8.1

FROM php:${PHP_VERSION}-alpine

RUN set -eux; \
    apk --no-cache update && \
    apk --no-cache upgrade

RUN set -eux; \
    apk --no-cache update && \
    apk --no-cache add tzdata git zip unzip freetype-dev libxml2-dev libjpeg-turbo-dev icu-dev icu g++ libzip-dev libmcrypt-dev libpng-dev libpq-dev libwebp-dev && \
    cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    echo "Europe/Berlin" > /etc/timezone

RUN docker-php-ext-configure gd \
      --with-freetype=/usr/include/ \
      --with-jpeg=/usr/include/ && \
  docker-php-ext-install gd zip intl pdo_mysql opcache mysqli exif

ENV PHP_INI_MEMORY_LIMIT=512M
RUN echo 'memory_limit = ${PHP_INI_MEMORY_LIMIT}' > "$PHP_INI_DIR/conf.d/docker-env.ini"

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1

COPY ./composer.json /root/.composer/composer.json 

RUN composer global install

ARG VERSION_FABOT_SECURITY_CHECKER=2.0.4
RUN curl -sSL https://github.com/fabpot/local-php-security-checker/releases/download/v${VERSION_FABOT_SECURITY_CHECKER}/local-php-security-checker_${VERSION_FABOT_SECURITY_CHECKER}_linux_amd64 -o /usr/local/bin/local-php-security-checker && \
    chmod +x /usr/local/bin/local-php-security-checker

ENV PATH=$PATH:/root/.composer/vendor/bin

WORKDIR /grumphp