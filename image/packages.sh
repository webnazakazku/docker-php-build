#!/bin/bash
set -e
source /build/buildconfig
set -x

## PPA Ondrej
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

apt-get update
apt-get dist-upgrade -y

## Often used tools.
$minimal_apt_get_install curl unzip git mysql-client postgresql-client \
	redis-tools

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
	php$1-mongodb \
	php$1-redis \
	php$1-xdebug

PHP_VER=`echo $1 | sed -e 's/\.//g'`
if [ "$PHP_VER" -le "74" ]; then
	# <= 7.4
	$minimal_apt_get_install php$1-json
fi
if [ "$PHP_VER" -le "71" ]; then
	# <= 7.1
	$minimal_apt_get_install php$1-mcrypt
fi
if [ "$PHP_VER" >= "70" ]; then
	$minimal_apt_get_install php$1-sodium
fi

#Utils
apt install -y bash-completion make nano

#Node.js
curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh
chmod 500 nsolid_setup_deb.sh
./nsolid_setup_deb.sh 21
rm nsolid_setup_deb.sh
apt-get install -y nodejs

#MongoDB client
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
   gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list

apt-get update

apt-get install -y mongodb-org-shell

#Yarn
corepack enable
cd /root && yarn init -2

# Grunt
npm install -g grunt

# Composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

mkdir /cache

# NPM: cache
npm config set cache /cache/npm

composer global require php-parallel-lint/php-parallel-lint:@stable
composer global require nette/code-checker:@stable

php -v
