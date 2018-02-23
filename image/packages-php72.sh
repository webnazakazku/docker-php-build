#!/bin/bash
set -e
source /build/buildconfig
set -x

## PPA Ondrej
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

apt-get update

## Often used tools.
$minimal_apt_get_install curl unzip git mysql-client postgresql-client \
	redis-tools mongodb-clients nodejs nodejs-legacy npm

## PHP packages
$minimal_apt_get_install \
	php7.2-bcmath \
	php7.2-bz2 \
	php7.2-cli \
	php7.2-curl \
	php7.2-gd \
	php7.2-imap \
	php7.2-intl \
	php7.2-json \
	php7.2-mbstring \
	php7.2-mysql \
	php7.2-opcache \
	php7.2-pgsql \
	php7.2-readline \
	php7.2-soap \
	php7.2-sqlite3 \
	php7.2-xml \
	php7.2-zip \
	php-mongodb \
	php-redis

# Grunt and bower
npm install -g grunt bower

# Composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

mkdir /cache

# NPM: cache
npm config set cache /cache/npm

# Composer speedup
composer global require hirak/prestissimo:@stable
composer global require jakub-onderka/php-parallel-lint:@stable
composer global require nette/code-checker:~2.5.0
