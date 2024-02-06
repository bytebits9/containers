ARG PHP_VERSION

FROM nuldark/php-fpm:${PHP_VERSION}

RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
        ${PHPIZE_DEPS} \
        curl \
        curl-dev \
        freetype-dev \
        oniguruma-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
        libpq-dev; \
    \
      mkdir -p /usr/src/php/ext/apcu && curl -fsSL https://pecl.php.net/get/apcu | tar xvz -C "/usr/src/php/ext/apcu" --strip 1; \
      mkdir -p /usr/src/php/ext/redis && curl -fsSL https://pecl.php.net/get/redis | tar xvz -C "/usr/src/php/ext/redis" --strip 1; \
    \
      docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp; \
    \
      docker-php-ext-install \
        curl \
        gd \
        mbstring \
        opcache \
        pdo \
        pdo_pgsql \
        redis \
        soap \
        xml \
        zip; \
    \
        runDeps="$( \
          scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
        )";  \
        apk add --no-cache $runDeps; \
        apk del --no-network .build-deps; \
    \
        rm -rf /var/cache/apk/*; \
        rm -rf /usr/src/php

 
