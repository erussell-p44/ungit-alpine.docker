FROM alpine:latest
MAINTAINER IPBurger <accounts@ipburger.com>

RUN \
    echo "Installing node.js and git" \
    && apk add --update nodejs git \
    && echo "Installing ungit with npm" \
    && npm install -g ungit \
    && echo "Cleaning apk..." \
    && apk del --progress --purge && rm -rf /var/cache/apk/* \
    && echo "ALL DONE"

EXPOSE 8448
CMD ["/usr/bin/ungit"]

WORKDIR /vso
