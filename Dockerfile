FROM centos:7

MAINTAINER Robert de Bock

LABEL Description="Base CentOS image" Version="1.0"

RUN yum -y install openssh openssh-server && \
    yum -y clean all
RUN /usr/bin/cp -af /etc/localtime /var/empty/sshd/etc

ADD sshd.conf /etc/ssh/sshd.conf

CMD /usr/bin/ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -C '' -N ''&&  \
    /usr/bin/ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''&&  \
    /usr/bin/ssh-keygen -q -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -C '' -N ''&&  \
    /usr/bin/ssh-keygen -t dsa -f /root/.ssh/id_dsa && \
    /usr/bin/cp /root/.ssh/id_dsa.pub /root/.ssh/authorized_keys && \
    /usr/bin/echo "Please save this private RSA key and login using \"ssh -i \${savedkey} root@\${ipaddress}" && \
    /usr/bin/cat /root/.ssh/id_dsa && \
    /usr/sbin/sshd -D -d

EXPOSE 22
