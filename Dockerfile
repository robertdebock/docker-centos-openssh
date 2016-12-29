FROM centos:7.3.1611

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" Version="7.3.1611"

ENV TINI_VERSION v0.13.2

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

EXPOSE 22

RUN yum -y install openssh openssh-server openssh-clients epel-release && \
    yum -y clean all

ADD start.sh /start.sh

RUN chmod +x /start.sh

RUN chmod +x /tini

ENTRYPOINT ["/tini", "-g", "--"]

CMD /start.sh
