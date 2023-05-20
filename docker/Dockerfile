ARG PHP_VERSION=8.2

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

ENV PATH=$PATH:/root/.composer/vendor/bin

WORKDIR /grumphp