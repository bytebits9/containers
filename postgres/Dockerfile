ARG POSTGRES_VERSION=alpine
FROM postgres:${POSTGRES_VERSION}

LABEL org.opencontainers.image.source=https://github.com/bytebits9/containers/postgres
LABEL org.opencontainers.image.description="postgres"
LABEL org.opencontainers.image.licenses=MIT

COPY postgres.conf /usr/local/share/postgresql/postgres.conf

ENV POSTGRES_SSL 'off'
ENV POSTGRES_CA_FILE 'ca.cert'
ENV POSTGRES_CERT_FILE 'server.cert'
ENV POSTGRES_KEY_FILE 'server.key'

RUN sed -i "s#ssl = __POSTGRES_SSL#ssl = ${POSTGRES_SSL}#" /usr/local/share/postgresql/postgres.conf && \
    sed -i "s#ssl_ca_file = '__POSTGRES_CA_FILE'#ssl_ca_file = '${POSTGRES_CA_FILE}'#" /usr/local/share/postgresql/postgres.conf && \
    sed -i "s#ssl_cert_file = '__POSTGRES_CERT_FILE'#ssl_cert_file = '${POSTGRES_CERT_FILE}'#" /usr/local/share/postgresql/postgres.conf && \
    sed -i "s#ssl_key_file = '__POSTGRES_KEY_FILE'#ssl_key_file = '${POSTGRES_KEY_FILE}'#" /usr/local/share/postgresql/postgres.conf 

CMD [ "postgres" ]

EXPOSE 5432