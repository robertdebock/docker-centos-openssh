[![Build Status](https://travis-ci.org/robertdebock/docker-centos-openssh.svg?branch=master)](https://travis-ci.org/robertdebock/docker-centos-openssh) [![](https://images.microbadger.com/badges/image/robertdebock/docker-centos-openssh.svg)](http://microbadger.com/images/robertdebock/docker-centos-openssh "Get your own image badge on microbadger.com")

# docker-centos-openssh
A CentOS 7 container that runs openssh server.

You can use this container to quickly startup a "machine" and test things, or it can be used as an SSH server, maybe a stepstone.

This container will generate new keys (host and user) at startup if none are loaded by attaching a volume.

## Running the container.
It's quite easy to start a container:

    docker run -P robertdebock/docker-centos-openssh
    
A private key will be displayed, copy-pasts-save it, set the permissions to 0600.

Find out what port Docker has connected to the container:

    docker port docker-centos-openssh

And connect to the container:

    ssh -p ${port} -i ${savedkey} root@${ip}

The ${ip} depends on where the container is running.

## Using your own private key
Simply save your key in a folder like "dot-ssh" and map the volumes:

    docker run -P -v $(pwd)/./ssh:/root/.ssh/ robertdebock/docker-centos-openssh

## Using with docker-compose
You may setup a testlab, for example for Ansible or Rundeck, using Docker-compose, like so:

    version: '3'
    services:
      server:
        image: robertdebock/docker-centos-openssh
        volumes:
          - /path/to/dot-ssh:/root/.ssh/
        links:
          - client1
          - client2
          - client3
        ports:
          - "2222:22"
      client1:
        image: robertdebock/docker-centos-openssh
        volumes:
          - /path/to/dot-ssh:/root/.ssh/
      client2:
        image: robertdebock/docker-centos-openssh
        volumes:
          - /path/to/dot-ssh:/root/.ssh/
      client3:
        image: robertdebock/docker-centos-openssh
        volumes:
          - /path/to/dot-ssh:/root/.ssh/


# Technologies used to build and test
[Travis CI](https://travis-ci.org/robertdebock/docker-centos-openssh) is used to build, run and test the image.
[Docker Hub](https://hub.docker.com/r/robertdebock/docker-centos-openssh/) is used to deploy the image to.
This (building on Travis CI and publishing to Docker Hub) happens in parallel. On Travis CI, few project are used:
- [Bats](https://github.com/sstephenson/bats) for testing.
- [Docker Lint](https://github.com/projectatomic/dockerfile_lint) for finding weird errors.

A bit weird about this setup is that when the build fails, an image is still published.

