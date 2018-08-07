FROM php:7.0-apache
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y \
    bash \
    git \
    ca-certificates \
    curl \
    zip
RUN a2enmod proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer proxy_connect proxy_html substitute expires
RUN docker-php-ext-install pdo pdo_mysql zip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require "hirak/prestissimo:^0.3" 
