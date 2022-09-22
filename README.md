# CUDA QuickStart

A docker image to quick start your CUDA development

## Docker-compose
To set up this docker image on your machine you can use the following docker-compose.

```yaml
---
version: "2.1"
services:
  cuda-starter:
    image: solomspd/cuda-starter
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Africa/Cairo
      - DEFAULT_WORKSPACE=/config/workspace
    ports:
      - 8443:8443
      - 22:22
    restart: unless-stopped
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]

```

To start debugging and building, take a look at the workspace directory that has every you need to get started including a simple build environment and hello world program.