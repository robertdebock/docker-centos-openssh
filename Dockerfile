FROM centos:7.7.1908

LABEL Maintainer="Robert de Bock <robert@meinit.nl>" Description="Base CentOS OpenSSH server image" CentOS="7.7.1908" OpenSSH="7.4p1-21.el7" Tini="0.18.0" Name="CentOS OpenSSH" VERSION="2"

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
