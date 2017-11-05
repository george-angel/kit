FROM nvidia/cuda:8.0-devel-ubuntu16.04

ARG RELEASE=x

RUN apt-get update && \
 apt-get -y install curl && \
 curl -L -O https://github.com/ethereum-mining/ethminer/releases/download/v${RELEASE}/ethminer-${RELEASE}-Linux.tar.gz && \
 tar xzf ethminer-${RELEASE}-Linux.tar.gz

ENTRYPOINT ["/bin/ethminer"]
