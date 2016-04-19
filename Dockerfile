FROM centos:7

MAINTAINER Robert de Bock

LABEL Description="Base CentOS image" Version="1.0"

RUN yum -y install openssh openssh-server && \
    yum -y clean all

ADD sshd.conf /etc/ssh/sshd.conf

CMD /usr/bin/ssh-keygen -q -t rsa1 -f /etc/ssh/ssh_host_key -C '' -N '' && \
    /usr/bin/ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N '' && \
    /usr/bin/ssh-keygen -q -t dsa -f /etc/ssh/ssh_host_dsa_key -C '' -N '' && \
    /usr/bin/cp -af /etc/localtime /var/empty/sshd/etc && \
    /usr/sbin/sshd -D

EXPOSE 22
