FROM centos

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" Version="1.0"

RUN yum -y install openssh openssh-server openssh-clients epel-release && yum -y clean all
RUN yum -y install nginx && yum clean all

CMD /usr/bin/ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -C '' -N ''&&  \
    /usr/bin/ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''&&  \
    /usr/bin/ssh-keygen -q -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -C '' -N ''&&  \
    /usr/bin/ssh-keygen -t dsa -f /root/.ssh/id_dsa -N '' && \
    /usr/bin/cp /root/.ssh/id_dsa.pub /root/.ssh/authorized_keys && \
    /usr/bin/echo "<html><head><title>private key</title></head><body><blockquote>" > /usr/share/nginx/html/index.html && \
    /usr/bin/cat /root/.ssh/id_dsa >> /usr/share/nginx/html/index.html && \
    /usr/bin/echo "</blockquote></body></html>" >> /usr/share/nginx/html/index.html && \
    (/usr/sbin/nginx &) && \
    /usr/bin/cat /root/.ssh/id_dsa && \
    /usr/bin/echo "Please save the printed private DSA key and login using:" && \
    /usr/bin/echo "\"ssh -i \${savedkey} root@\${ipaddress}\"" && \
    /usr/sbin/sshd -D

EXPOSE 22
EXPOSE 80
EXPOSE 443
