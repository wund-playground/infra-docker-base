# Base images for Docker that are always up to date
[![Docker build](https://img.shields.io/docker/automated/cryptton2004/base.svg)](https://hub.docker.com/r/cryptton2004/base/)

To see all the available images, please go to [this Docker Hub page](https://hub.docker.com/r/cryptton2004/base/).

---

## Development

Build the images (Steamcmd used as an example):
``` windows cmd
docker build -t steamcmd -f Dockerfiles\steamcmd\Dockerfile .

```


## Licenses

This project is provided under the [MIT License](https://github.com/wund-playground/infra-docker-base/blob/master/LICENSE.md)


## Authors
This repo is an adaptation of the original, all credits go here : https://github.com/Didstopia/docker-base-images