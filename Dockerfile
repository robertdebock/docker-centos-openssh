FROM centos:7

MAINTAINER Robert de Bock

LABEL Description="Base CentOS image" Version="1.0"

RUN yum -y install openssh openssh-server && yum -y clean all

CMD /usr/bin/ssh-keygen -t dsa -f /root/.ssh/id_dsa && \
    cat /root/.ssh/id_dsa | /usr/bin/tee /root/.ssh/authorized_keys && \
    /usr/bin/echo "Please save the printed private RSA key and login using:" && \
    /usr/bin/echo "\"ssh -i \${savedkey} root@\${ipaddress}\"" && \
    /usr/sbin/sshd -D

EXPOSE 22
