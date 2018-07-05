FROM alpine:latest
MAINTAINER IPBurger <accounts@ipburger.com>

RUN \
    echo "Installing node.js, git and openssh" \
    && apk add --update nodejs git openssh \
    && echo "Installing ungit with npm" \
    && npm install -g ungit \
    && echo "Cleaning apk..." \
    && apk del --progress --purge && rm -rf /var/cache/apk/* \
    && echo "ALL DONE"

COPY .ungitrc /root/.ungitrc

EXPOSE 8448

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /git

CMD ["/usr/bin/ungit"]
