# Docker image for running PHP on CI

* Based on [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker) (but thrown away everything what is not needed for CI)
* PHP installed from [Ondrej Sury's Ubuntu PPA](https://launchpad.net/~ondrej/+archive/ubuntu/php) which contains almost any posiible package

## APT packages added

* curl
* unzip
* git
* mysql-client
* postgresql-client
* redis-tools
* mongodb-clients
* nodejs
* nodejs-legacy
* npm
* yarn

## PHP packages installed

* bcmath
* bz2
* cli
* curl
* gd
* imap
* intl
* json
* mbstring
* mcrypt
* mysql
* opcache
* pgsql
* readline
* soap
* sqlite3
* xml
* zip
* mongodb
* redis

## NPM packages globally installed

* grunt

## Composer packages globally installed

* [composer](https://getcomposer.org/) (of course)
* [jakub-onderka/php-parallel-lint](https://github.com/JakubOnderka/PHP-Parallel-Lint) which tests PHP syntax in parallel
* [nette/code-checker](https://github.com/nette/code-checker) which checks for coding style and template error in Nette framework

## Cache dirs redirected

 * NPM: `/cache/npm`
 * Composer: `/cache/composer`

You may want to set `/cache` dir as Docker image volume for faster CI build.

## ENV variables changed/added

 * `$PATH`: added `~/.composer/vendor/bin`
 * `$COMPOSER_NO_INTERACTION`: set to `1`

## Tags (and PHP version) available for Docker

* 5.6
* 7.0
* 7.1
* 7.2
* 7.3
* 7.4
* 8.0
