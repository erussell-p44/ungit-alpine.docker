FROM alpine:latest
MAINTAINER IPBurger <accounts@ipburger.com>

# TODO: Install and configure openssh on this container,
# some config ideas from: https://hub.docker.com/r/alexdpy/ungit/
#
# docker run -it --rm -p 8448:8448 -v $PWD:/var/www -v /etc/ssh/ssh_config:/etc/ssh/ssh_config
# -v ~/.ssh:/home/ungit/.ssh -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent alexdpy/ungit

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
