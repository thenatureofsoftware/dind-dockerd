FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install --no-install-recommends apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get install --no-install-recommends -y docker-ce && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY daemon.json /etc/docker/daemon.json

ENTRYPOINT dockerd --config-file="/etc/docker/daemon.json"

EXPOSE 2375