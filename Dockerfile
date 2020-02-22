FROM centos:8

LABEL Maintainer="Robert de Bock <robert@meinit.nl>"
LABEL Description="Base CentOS OpenSSH server image"
LABEL CentOS="8"
LABEL OpenSSH="7.4p1-21.el7"
LABEL Tini="0.18.0"
LABEL Name="CentOS OpenSSH"
LABEL VERSION="2"

ENV TINI_VERSION v0.18.0

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

EXPOSE 22

RUN yum -y erase vim-minimal iputils libss && \
    yum -y install openssh openssh-server openssh-clients && \
    yum -y clean all

ADD start.sh /start.sh

RUN chmod +x /start.sh /tini

ENTRYPOINT ["/tini", "-g", "--"]

CMD /start.sh
