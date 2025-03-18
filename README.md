# Monero-docker

```
git clone https://github.com/Mingg817/monero-docker.git
cd monero-docker
wget https://raw.githubusercontent.com/monero-project/monero/refs/heads/master/utils/gpg_keys/binaryfate.asc
docker build -t monero-docker .
```

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

**Please modify the parameters of CMD as necessary.**