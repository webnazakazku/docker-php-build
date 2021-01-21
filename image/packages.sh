#!/bin/bash
set -e
source /build/buildconfig
set -x

## PPA Ondrej
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

apt-get update

## Often used tools.
$minimal_apt_get_install curl unzip git mysql-client postgresql-client \
	redis-tools mongodb-clients

## PHP packages
$minimal_apt_get_install \
	php$1-bcmath \
	php$1-bz2 \
	php$1-cli \
	php$1-curl \
	php$1-gd \
	php$1-imap \
	php$1-intl \
	php$1-mbstring \
	php$1-mysql \
	php$1-opcache \
	php$1-pgsql \
	php$1-readline \
	php$1-soap \
	php$1-sqlite3 \
	php$1-xml \
	php$1-zip \
	php-mongodb \
	php-redis

PHP_VER=`echo $1 | sed -e 's/\.//g'`
if [ "$PHP_VER" -le "71" ]; then
	# <= 7.1
	$minimal_apt_get_install php$1-mcrypt
fi
if [ "$PHP_VER" == "70" ]; then
	$minimal_apt_get_install php$1-sodium
fi
if [ "$PHP_VER" == "71" ]; then
	$minimal_apt_get_install php$1-sodium
fi

#Node.js
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs

#Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

apt-get update

apt-get install -y yarn

# Grunt and bower
npm install -g grunt bower

# Composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

mkdir /cache

# NPM: cache
npm config set cache /cache/npm

composer global require jakub-onderka/php-parallel-lint:@stable
composer global require nette/code-checker:~2.5.0
