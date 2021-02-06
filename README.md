# Base images for Docker that are always up to date
[![SteamCMD Docker build](https://img.shields.io/docker/automated/cryptton2004/steamcmd.svg)](https://hub.docker.com/r/cryptton2004/steamcmd/)

[![Ubuntu 18 build](https://img.shields.io/docker/automated/cryptton2004/ubuntu18.svg)](https://hub.docker.com/r/cryptton2004/ubuntu18/)


To see all the available steamcmd images, please go to [this Docker Hub page](https://hub.docker.com/r/cryptton2004/steamcmd/).

To see all the available ubuntu18 images, please go to [this Docker Hub page](https://hub.docker.com/r/cryptton2004/ubuntu18/).

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