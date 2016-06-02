FROM php:cli

# gd
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev && apt-get clean
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && docker-php-ext-install -j$(nproc) gd

# mbstring
RUN docker-php-ext-install -j$(nproc) mbstring

# json
RUN docker-php-ext-install -j$(nproc) json

# bcmath
RUN docker-php-ext-configure bcmath
RUN docker-php-ext-install -j$(nproc) bcmath

# mcrypt
RUN apt-get update && apt-get install -y libmcrypt-dev && apt-get clean
RUN docker-php-ext-install -j$(nproc) mcrypt

# zip
RUN docker-php-ext-install -j$(nproc) zip

# mysql
RUN docker-php-ext-install -j$(nproc) mysqli pdo_mysql

# imagick
#RUN apt-get update && apt-get install -y libmagickwand-6.q16-dev
#RUN ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin
#RUN pecl install -o -f imagick && docker-php-ext-enable imagick

# xdebug
RUN pecl install -o -f xdebug && docker-php-ext-enable xdebug

# php.ini
COPY conf/php.ini /usr/local/etc/php/

# xdebugu configuration
COPY conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

CMD ["php"]

WORKDIR /var/www/html