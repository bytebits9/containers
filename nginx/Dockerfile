ARG NGINX_VERSION=alpine
FROM nginx:${NGINX_VERSION}

LABEL org.opencontainers.image.source=https://github.com/bytebits9/containers/nginx
LABEL org.opencontainers.image.description="nginx"
LABEL org.opencontainers.image.licenses=MIT

COPY nginx.conf /etc/nginx/

RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && apk add --no-cache bash \
    && apk add --no-cache curl

RUN set -x ; \
    addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

EXPOSE 80 443