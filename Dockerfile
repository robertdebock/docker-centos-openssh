FROM centos

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" Version="1.0"

RUN yum -y install openssh openssh-server openssh-client && yum -y clean all

CMD /usr/bin/ssh-keygen -t dsa -f /root/.ssh/id_dsa && \
    cat /root/.ssh/id_dsa | /usr/bin/tee /root/.ssh/authorized_keys && \
    /usr/bin/echo "Please save the printed private DSA key and login using:" && \
    /usr/bin/echo "\"ssh -i \${savedkey} root@\${ipaddress}\"" && \
    /usr/sbin/sshd -D

EXPOSE 22
