FROM tehraven/alpinewebos:latest
MAINTAINER "https://github.com/tehraven"
# BUILDS tehraven/eve-amsys

ENV BUILD_VERSION=1.0.1
ENV BUILD_ENV=dev

WORKDIR /var/www/

COPY composer.json /var/www/composer.json
COPY app /var/www/app
COPY src /var/www/src
COPY web /var/www/web
COPY app/config/parameters.yml.dist /var/www/app/config/parameters.yml

RUN mkdir /var/www/app/cache/dev \
	&& mkdir /var/www/app/cache/prod \
	&& touch /var/log/nginx/amsys.access \
	&& touch /var/log/nginx/amsys.error \
	&& chown -R www-data:www-data /var/log/nginx/ \
	&& chown -R www-data:www-data /var/www/ \
	&& composer install \
	&& chown -R www-data:www-data /var/www/app/ \
	&& chown -R www-data:www-data /var/www/app/Resources \
	&& chown -R www-data:www-data /var/www/app/cache

ADD docker/servers/web/root /

WORKDIR /var/www/
EXPOSE 80