# Monero-docker

```
git clone https://github.com/Mingg817/monero-docker.git
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
```
docker run -it -d \
    --name=monero \
    --restart=always \
    -p 18080:18080 \
    -p 18081:18081 \
    -v <your Monero data file path>:/data \
    monero-docker
```
