FROM jpreuss/php:noxdebug

# xdebug
RUN pecl install -o -f xdebug && docker-php-ext-enable xdebug