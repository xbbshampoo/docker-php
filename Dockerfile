# syntax=docker/dockerfile:1
ARG PHP_VERSION=8.1
ARG SERVER_TYPE=apache

FROM php:$PHP_VERSION-$SERVER_TYPE

# Install unzip utility and libs needed by zip PHP extension
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    unzip && \
    rm -rf /var/lib/apt/lists/*

# install some base extensions
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN IPE_GD_WITHOUTAVIF=1 install-php-extensions amqp apcu bcmath bz2 calendar exif gd gmp imagick imap intl ldap mysqli opcache pcntl pdo_mysql pdo_pgsql pgsql redis xmlrpc zip xsl

# install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
