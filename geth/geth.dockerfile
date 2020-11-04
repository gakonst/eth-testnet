FROM ethereum/client-go
USER root

RUN apk add --update bash bind-tools

ADD start.sh /root/start.sh
ADD geth.json /root/genesis.json

ENTRYPOINT /root/start.sh
