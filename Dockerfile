FROM centos:7.3.1611

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" Version="7.3.1611"

RUN yum -y install openssh openssh-server openssh-clients epel-release && \
    yum -y clean all

EXPOSE 22

CMD start.sh
