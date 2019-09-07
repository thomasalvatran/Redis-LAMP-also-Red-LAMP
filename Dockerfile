#FROM php:7.3.2-fpm-stretch
FROM php:7.2.2-apache
# CMD echo "ServerName localhost" >> /etc/apache2/apache2.conf
# CMD ["/usr/sbin/apache2ctl", "-D", "DFOREGROUND"]
ENV EXT_REDIS_VERSION=4.3.0 EXT_IGBINARY_VERSION=3.0.1
#FROM php:7.2.2-apache
COPY src/ /var/www/html
EXPOSE 80
#ADD php.ini /usr/local/etc/php
ADD redis.ini /etc/php/7.2/apache2/conf.d/redis.ini
#ADD redis.ini /etc/php5/conf.d/redis.ini
#volumes:
#            - ./web:/var/www
#            - ./config/custom.php.ini:/etc/php5/apache2/conf.d/custom.php.ini
#RUN pecl install redis && docker-php-ext-enable redis
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && docker-php-source extract \
    # igbinary
    && mkdir -p /usr/src/php/ext/igbinary \
    &&  curl -fsSL https://github.com/igbinary/igbinary/archive/$EXT_IGBINARY_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/igbinary --strip 1 \
    && docker-php-ext-install igbinary \
    # redis
    && mkdir -p /usr/src/php/ext/redis \
    && curl -fsSL https://github.com/phpredis/phpredis/archive/$EXT_REDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && docker-php-ext-configure redis --enable-redis-igbinary \
    && docker-php-ext-install redis \
    # cleanup
    && docker-php-source delete
