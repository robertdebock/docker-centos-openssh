# docker-centos-openssh
A CentOS 7 container that runs openssh server

You can use this container to quickly startup a "machine" and test things, or it can be used as an SSH server, maybe a stepstone.

This container will generate new keys (host and user) at startup.

## Running the container.
It's quite easy to start a container:

    docker run -p 1234:22 robertdebock/docker-centos-openssh

A private key will be displayed, copy-pasts-save it and connect to the container:

    ssh -p 1234 -i ${savedkey} root@${ip}

That ${ip} depends on where the container is running.
