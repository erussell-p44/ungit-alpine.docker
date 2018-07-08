FROM node:8-alpine
MAINTAINER IPBurger <accounts@ipburger.com>

RUN \
    echo "Installing node.js, git and openssh" \
    && apk add --update git openssh bash \
    && echo "Installing ungit with npm" \
    && npm install -g ungit \
    && echo "Cleaning apk..." \
    && apk del --progress --purge && rm -rf /var/cache/apk/* \
    && echo "ALL DONE"

COPY .ungitrc /root/.ungitrc

EXPOSE 8448

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /git

COPY entry.sh /entry.sh
ENTRYPOINT ["/entry.sh"]

CMD ["/usr/bin/ungit"]
