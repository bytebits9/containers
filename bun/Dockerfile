FROM alpine:edge

RUN apk update \
    && apk upgrade \
    && apk add bash curl

RUN curl -fsSL https://bun.sh/install | bash