FROM alpine:3.14

RUN set -x \
    && apk add --update --no-cache \
       ca-certificates \
    && rm -rf /var/cache/apk/*
COPY polygon-edge /usr/local/bin/

EXPOSE 8545 9632 1478

RUN addgroup -S edge \
    && adduser -S edge -G edge

USER edge

ENTRYPOINT ["polygon-edge"]