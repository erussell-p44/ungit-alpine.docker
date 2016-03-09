FROM centos:centos7

RUN \
    echo "Installing node.js and stuff" \
    && curl --silent --location https://rpm.nodesource.com/setup_4.x | bash - \
    && yum install -y nodejs git \
    && echo "Installing ungit with npm" \
    && npm install -g ungit \
    && echo "Cleaning yum..." \
    && yum clean all \
    && echo "ALL DONE"

EXPOSE 8448
CMD ["/usr/bin/ungit"]

WORKDIR /vso

# CMD ["/bin/bash"]

