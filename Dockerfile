# syntax=docker/dockerfile:1
ARG PHP_VERSION=8.1
ARG SERVER_TYPE=apache

FROM php:$PHP_VERSION-$SERVER_TYPE

# Install unzip utility and libs needed by zip PHP extension
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    unzip

# install some base extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    IPE_GD_WITHOUTAVIF=1 install-php-extensions zip pdo_mysql pdo_pgsql bcmath gd

# install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
