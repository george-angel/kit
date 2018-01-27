FROM alpine:3.7

ARG TOR_VER=x
ENV TOR_URL https://www.torproject.org/dist/tor-$TOR_VER.tar.gz
ENV TOR_FILE tor.tar.gz
ENV TOR_TEMP tor-$TOR_VER

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
 openssl-dev && \
 # build tor
 wget -O $TOR_FILE $TOR_URL && \
 tar xzf $TOR_FILE && \
 cd $TOR_TEMP && \
 ./configure --prefix=/ --exec-prefix=/usr && \
 make install && \
 cd .. && \
 rm -rf $TOR_FILE $TOR_TEMP && \
 # tor user
 adduser -u 19001 -G root -S tor && \
 # bridge bin
 apk add --no-cache go git gcc libc-dev && \
 mkdir /go && \
 export GOPATH=/go && \
 go get git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy && \
 cp $GOPATH/bin/obfs4proxy /usr/local/bin/ && \
 # allow tor+obfs4 to bind to <1024 ports
 setcap CAP_NET_BIND_SERVICE=+eip $(which obfs4proxy) && \
 setcap CAP_NET_BIND_SERVICE=+eip $(which tor) && \
 # clean
 apk del build-base gmp-dev go git gcc libc-dev && rm -rf /go

ADD conf/*-torrc /etc/tor/
ADD docker-entrypoint /

ENTRYPOINT ["/docker-entrypoint"]
