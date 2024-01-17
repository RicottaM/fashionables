FROM alpine:3.17 as source

RUN apk update
RUN apk upgrade
RUN apk add git
RUN git clone -b klajster http://github.com/RicottaM/fashionables.git

FROM prestashop/prestashop-git:7.4

RUN rm -rf *

RUN apt update

RUN apt install -y \
    apt-utils \
    mailutils

RUN apt install -y --no-install-recommends \
        libc-client-dev \
        libkrb5-dev \
        ; \
        rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
	docker-php-ext-install imap

COPY --from=source /fashionables/Prestashop .

RUN chmod -R 755 .
RUN chown -R www-data:www-data .

RUN mv ./.docker/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN ./.docker/ssl.sh
RUN a2enmod ssl
RUN a2enmod rewrite

COPY ./launch.sh /tmp/
COPY ./dump /tmp/dump
#RUN rm -rf var/cache/prod/*