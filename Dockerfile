FROM centos:7

MAINTAINER Robert de Bock

LABEL Description="Base CentOS image" Version="1.0"

RUN yum -y install openssh openssh-server && \
    yum -y clean all
RUN /usr/bin/cp -af /etc/localtime /var/empty/sshd/etc

ADD sshd.conf /etc/ssh/sshd.conf

CMD /usr/bin/ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -C '' -N && \
    /usr/sbin/sshd -D

EXPOSE 22
