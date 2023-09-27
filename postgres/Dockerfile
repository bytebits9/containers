ARG POSTGRES_VERSION
FROM postgres:${POSTGRES_VERSION}

LABEL org.opencontainers.image.source=https://github.com/bytebits9/containers/postgres
LABEL org.opencontainers.image.description="postgres"
LABEL org.opencontainers.image.licenses=MIT

COPY postgres.conf /usr/local/share/postgresql/postgres.conf

CMD [ "postgres" ]

EXPOSE 5432