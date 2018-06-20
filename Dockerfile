FROM alpine:latest
MAINTAINER IPBurger <accounts@ipburger.com>

# TODO: Install and configure openssh on this container,
# some config ideas from: https://hub.docker.com/r/alexdpy/ungit/
#
# docker run -it --rm -p 8448:8448 -v $PWD:/var/www -v /etc/ssh/ssh_config:/etc/ssh/ssh_config
# -v ~/.ssh:/home/ungit/.ssh -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent alexdpy/ungit

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
