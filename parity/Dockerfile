# modified to clone openethereum
FROM rust as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

RUN git clone https://github.com/openethereum/openethereum /openethereum
RUN cargo build --release

FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /mev-geth/build/bin/geth /usr/local/bin/

EXPOSE 8545 8546 30303 30303/udp

FROM ethereum/client-go
USER root

RUN apk add --update bash bind-tools

ADD start.sh /root/start.sh
ADD geth.json /root/genesis.json

ENTRYPOINT /root/start.sh
