FROM centos:7.3.1611

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" Centos="7.3.1611" OpenSSH="6.6.1p1-31" Tini="0.13.2"

ENV TINI_VERSION v0.13.2

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

EXPOSE 22

RUN yum -y install openssh openssh-server openssh-clients && \
    yum -y clean all

ADD start.sh /start.sh

RUN chmod +x /start.sh

RUN chmod +x /tini

ENTRYPOINT ["/tini", "-g", "--"]

CMD /start.sh
