FROM nvidia/cuda:9.1-base

ARG RELEASE

RUN apt-get update && \
 apt-get -y install curl && \
 curl -L -O https://github.com/ethereum-mining/ethminer/releases/download/v${RELEASE}/ethminer-${RELEASE}-Linux.tar.gz && \
 tar xzf ethminer-${RELEASE}-Linux.tar.gz

ENTRYPOINT ["/bin/ethminer"]
