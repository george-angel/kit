FROM alpine:3.16

ARG TOR_VER=x
ENV TOR_URL https://dist.torproject.org/tor-${TOR_VER}.tar.gz
ENV TOR_FILE tor.tar.gz
ENV TOR_TEMP tor-${TOR_VER}

RUN apk --no-cache add \
      libcap \
      gettext \
      su-exec \
      build-base \
      gmp-dev \
      libevent \
      libevent-dev \
      libgmpxx \
      openssl \
      openssl-dev \
      zlib \
      zlib-dev \
      && wget -O ${TOR_FILE} ${TOR_URL} \
      && tar xzf ${TOR_FILE} \
      && cd ${TOR_TEMP} \
      && ./configure --prefix=/ --exec-prefix=/usr \
      && make install  \
      && cd .. \
      && rm -rf ${TOR_FILE} ${TOR_TEMP} \
      && adduser -u 19001 -G root -S tor \
      && apk add --no-cache go git gcc libc-dev \
      && git clone https://gitlab.com/yawning/obfs4.git \
      && (cd obfs4 && go build -o obfs4proxy/obfs4proxy ./obfs4proxy) \
      && cp ./obfs4/obfs4proxy/obfs4proxy /usr/local/bin/ \
      && rm -rf ./obfs4 \
      && setcap CAP_NET_BIND_SERVICE=+eip $(which obfs4proxy) \
      && setcap CAP_NET_BIND_SERVICE=+eip $(which tor) \
      && apk del build-base gmp-dev go git gcc libc-dev && rm -rf /go

ADD conf/*-torrc /etc/tor/
ADD docker-entrypoint /

ENTRYPOINT ["/docker-entrypoint"]
