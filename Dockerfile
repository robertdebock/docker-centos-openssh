FROM centos:8

LABEL Maintainer="Robert de Bock <robert@meinit.nl>"
LABEL Description="Base CentOS OpenSSH server image"
LABEL CentOS="8"
LABEL OpenSSH="8.0p1"
LABEL Tini="0.19.0"
LABEL Name="CentOS OpenSSH"
LABEL VERSION="2"
LABEL build_date="2021-12-30"

ENV TINI_VERSION v0.19.0

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

EXPOSE 22

# This containers function is specifically to run/test ssh, ignore hints
# about having openssh in a Dockerfile.
# "WARNING: installing SSH in a container is not recommended.
# Do you really need SSH in this image?"
# dockerfile_lint - ignore
RUN yum -y erase vim-minimal iputils libss && \
    yum -y install openssh openssh-server openssh-clients && \
    yum -y clean all

ADD start.sh /start.sh

RUN chmod +x /start.sh /tini

ENTRYPOINT ["/tini", "-g", "--"]

CMD /start.sh
