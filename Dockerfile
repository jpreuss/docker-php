FROM php:5.6-apache

RUN a2enmod rewrite headers

# gd
RUN apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install -j$(nproc) gd \
    && rm -rf /var/lib/apt/lists/*

# mbstring
RUN docker-php-ext-install -j$(nproc) mbstring

# json
RUN docker-php-ext-install -j$(nproc) json

# bcmath
RUN docker-php-ext-configure bcmath \
    && docker-php-ext-install -j$(nproc) bcmath

# mcrypt
RUN apt-get update \
    && apt-get install -y libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt \
    && rm -rf /var/lib/apt/lists/*

# zip
RUN docker-php-ext-install -j$(nproc) zip

# mysql
RUN docker-php-ext-install -j$(nproc) mysqli pdo_mysql

# xdebug
RUN pecl install -o -f xdebug-2.5.5 \
    && docker-php-ext-enable xdebug

# intl
RUN apt-get update \
    && apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && rm -rf /var/lib/apt/lists/*

# php.ini
COPY conf/php.ini /usr/local/etc/php/php.ini

# xdebugu configuration
COPY conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini