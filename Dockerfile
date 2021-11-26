FROM php:7.4-apache

# Configuring server to host CI-4 application
RUN apt-get update && apt-get upgrade -y &&\
    apt-get install autoconf libicu-dev zip unzip openssh-client -y &&\
    echo "ServerName localhost" >> /etc/apache2/apache2.conf &&\
    sed -i 's%/var/www/html%/var/www/html/public%g' \
    "/etc/apache2/sites-available/000-default.conf" &&\
    a2enmod rewrite &&\
    service apache2 restart

# Cnfiguring php extensions
RUN docker-php-ext-install mysqli intl &&\
    docker-php-ext-enable mysqli

# Installing composer and preparing inputs
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
EXPOSE 80
