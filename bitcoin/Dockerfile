FROM alpine:3.7

# Expose mainnet ports (server, rpc)
EXPOSE 8333 8334

# Expose testnet ports (server, rpc)
EXPOSE 18333 18334

# Expose simnet ports (server, rpc)
EXPOSE 18555 18556

# Expose segnet ports (server, rpc)
EXPOSE 28901 28902

COPY "btcctl.sh" .
COPY "btcd.sh" .

ENV GOPATH=/go

RUN mkdir /root/.btcd && \
 mkdir /root/.btcctl && \
 chmod +x btcctl.sh && \
 chmod +x btcd.sh && \
 mkdir /go && \
 export PATH=$PATH:$GOPATH/bin && \
 apk --no-cache add go git musl-dev bash && \
 go get -u github.com/Masterminds/glide && \
 git clone https://github.com/btcsuite/btcd $GOPATH/src/github.com/btcsuite/btcd && \
 cd $GOPATH/src/github.com/btcsuite/btcd && \
 glide install && \
 go install . ./cmd/... && \
 apk del go git musl-dev

ENTRYPOINT ["/btcd.sh"]
