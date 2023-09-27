ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}

LABEL org.opencontainers.image.source=https://github.com/bytebits9/containers/nginx
LABEL org.opencontainers.image.description="nginx"
LABEL org.opencontainers.image.licenses=MIT

COPY nginx.conf /etc/nginx/
COPY sites-available/default.conf /etc/nginx/sites-available/default.conf

RUN apk update \
    && apk upgrade \
    && apk add openssl

RUN set -x ; \
    addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

EXPOSE 80 443