# Monero-docker

```
git clone https://github.com/eeeming/monero-docker.git
cd monero-docker
wget https://raw.githubusercontent.com/monero-project/monero/refs/heads/master/utils/gpg_keys/binaryfate.asc
docker build -t monero-docker .
```

You may need to set up the PROXY to download from `getmonero.org`.

```
docker build --build-arg HTTP_PROXY=<HTTP_PROXY address> --build-arg HTTPS_PROXY=<HTTPS_PROXY address> -t monero-docker .
```

> Tips: DO NOT USING `127.0.0.1` in the `HTTP_PROXY` and `HTTPS_PROXY` settings.

RUN docker image

Use host networking so `monerod` binds the host's global IPv6 address and can advertise it for P2P. Bridge NAT only gives the container a unique-local IPv6, which other nodes cannot dial.

```
docker run -d \
    --name=monero \
    --restart=always \
    --network host \
    -v <your Monero data file path>:/data \
    monero-docker
```

Do not publish `-p 18080:18080` / `-p 18081:18081` with `--network host`; the daemon listens on those ports on the host directly.
