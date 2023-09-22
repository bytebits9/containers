ARG REDIS_VERSION=alpine
FROM redis:${REDIS_VERSION}

LABEL org.opencontainers.image.source=https://github.com/bytebits9/containers/redis
LABEL org.opencontainers.image.description="redis"
LABEL org.opencontainers.image.licenses=MIT

VOLUME "/data"

EXPOSE 6379

CMD [ "redis-server" ]