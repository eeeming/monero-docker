FROM ubuntu:24.04

ARG MONERO_VERSION=v0.18.4.2

RUN apt-get update && \
    apt-get install -y wget gpg bzip2&& \
    apt-get clean

COPY ./binaryfate.asc .

RUN gpg --import binaryfate.asc && \
    wget https://downloads.getmonero.org/cli/monero-linux-x64-${MONERO_VERSION}.tar.bz2 -P . && \
    wget https://www.getmonero.org/downloads/hashes.txt -P . && \
    gpg --verify hashes.txt && \
    sha256sum monero-linux-x64-${MONERO_VERSION}.tar.bz2 && \
    grep monero-linux-x64-${MONERO_VERSION}.tar.bz2 hashes.txt && \
    bash -c "set -e; diff <(sha256sum monero-linux-x64-${MONERO_VERSION}.tar.bz2) <(grep monero-linux-x64-${MONERO_VERSION}.tar.bz2 hashes.txt)" && \
    tar -xjvf ./monero-linux-x64-${MONERO_VERSION}.tar.bz2 && \
    rm ./monero-linux-x64-${MONERO_VERSION}.tar.bz2 && \
    mv ./monero-x86_64-linux-gnu-${MONERO_VERSION} /monero

EXPOSE 18080 18081

VOLUME /data

ENTRYPOINT ["/monero/monerod"]

CMD [\
    "--data-dir=/data",\
    "--p2p-bind-ip=0.0.0.0", \
    "--p2p-bind-port=18080",\
    "--p2p-use-ipv6", \
    "--rpc-bind-ip=0.0.0.0", \
    "--rpc-bind-ipv6-address=::",\
    "--rpc-bind-port=18081",\
    "--rpc-use-ipv6",\
    "--non-interactive", \
    "--confirm-external-bind",\
    "--restricted-rpc",\
    "--db-sync-mode=safe:sync"\
    ,"--disable-dns-checkpoints"\
    ]
