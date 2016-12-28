FROM centos:7.3.1611

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" Version="7.3.1611"

EXPOSE 22

RUN yum -y install openssh openssh-server openssh-clients epel-release && \
    yum -y clean all

ADD start.sh /start.sh

RUN chmod +x /start.sh

CMD /start.sh
