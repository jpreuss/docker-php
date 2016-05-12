FROM php:cli

# zip
RUN apt-get update && apt-get install -y zlib1g-dev && apt-get clean
RUN docker-php-ext-install -j$(nproc) zip
RUN apt-get remove -y zlib1g-dev

# php.ini
COPY conf/php.ini /usr/local/etc/php/

CMD ["php"]

WORKDIR /var/www/html