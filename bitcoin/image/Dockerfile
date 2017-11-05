FROM alpine:3.6

ARG VER=x
ENV FILE bitcoin.tar.gz
ENV URL https://bitcoin.org/bin/bitcoin-core-${ENV}/bitcoin-${ENV}-x86_64-linux-gnu.tar.gz
ENV TMP=bitcoin-${VER}

RUN apk --no-cache add curl && \
 wget -O ${FILE} ${URL} \
 tar xzf ${FILE} \
  
