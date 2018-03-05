FROM centos:7.3.1611

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" CentOS="7.3.1611" OpenSSH="7.4p1-13.el7_4" Tini="0.14.0" Name="CentOS OpenSSH" VERSION="2"

ENV http_proxy="http://child-prc.intel.com:913"
ENV https_proxy="http://child-prc.intel.com:913"
ENV no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com,10.*,192.168.*,172.18.*,*.intel.com"

ENV TINI_VERSION v0.14.0

ADD https://github.com/krallin/tini/releases/tag/${TINI_VERSION}/tini /tini

EXPOSE 22

RUN yum -y erase vim-minimal yum-plugin-ovl iputils libss && \
    yum -y install openssh openssh-server openssh-clients && \
    yum -y clean all

ADD start.sh /start.sh

RUN chmod +x /start.sh /tini

ENTRYPOINT ["/tini", "-g", "--"]

CMD /start.sh
