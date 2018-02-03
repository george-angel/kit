FROM gcr.io/google-containers/debian-base-amd64:0.3

EXPOSE 8332 8333

ARG BITCOIN_VERSION

ENV BITCOIN_URL https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz
ENV BITCOIN_SHA256 387c2e12c67250892b0814f26a5a38f837ca8ab68c86af517f975a2a2710225b
ENV BITCOIN_ASC_URL https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS.asc
ENV BITCOIN_PGP_KEY 01EA5486DE18A882D4C2684590C8019E36C2E964
ENV BITCOIN_DATA /bitcoin/data
ENV HOME /bitcoin

VOLUME /bitcoin/data

COPY bitcoin.conf /etc/

RUN \
 useradd -U -M -s /usr/sbin/nologin -d /bitcoin bitcoin && \
 apt-get update && \
 apt-get upgrade -y && \
 apt-get install -y --no-install-recommends gosu bash gnupg dirmngr ca-certificates wget && \
 # bitcoind
 cd /tmp && \
 wget -qO bitcoin.tar.gz "$BITCOIN_URL" && \
 echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - && \
 gpg --keyserver keyserver.ubuntu.com --recv-keys "$BITCOIN_PGP_KEY" && \
 wget -qO bitcoin.asc "$BITCOIN_ASC_URL" && \
 gpg --verify bitcoin.asc && \
 tar -xzvf bitcoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt && \
 cd / && \
 # files
 mkdir -p /bitcoin/.bitcoin && \
 ln -s /etc/bitcoin.conf /bitcoin/.bitcoin/bitcoin.conf && \
 chown -R bitcoin: /bitcoin && \
 # clean
 apt-get purge -y --auto-remove ca-certificates wget gnupg dirmngr && \
 apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

COPY entrypoint /

ENTRYPOINT ["/entrypoint"]
CMD ["bitcoind"]
