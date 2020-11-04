# modified to clone MEV-GETH
# https://github.com/flashbots/mev-geth/blob/master/Dockerfile
FROM golang:1.15-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

RUN git clone https://github.com/flashbots/mev-geth /mev-geth
RUN cd /mev-geth && make geth

FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /mev-geth/build/bin/geth /usr/local/bin/

EXPOSE 8545 8546 30303 30303/udp

RUN apk add --update bash bind-tools

# This is meant to be executed from the repo's root directory
COPY start.sh /root/start.sh
ADD geth.json /root/genesis.json

ENTRYPOINT /root/start.sh
