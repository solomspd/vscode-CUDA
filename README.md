# vscode-CUDA

A docker image to quick start your CUDA development

## Docker-compose

```yaml
---
version: "2.1"
services:
  code-server:
	image: lscr.io/linuxserver/code-server:latest
	container_name: code-server
	environment:
	  - PUID=1000
	  - PGID=1000
	  - TZ=Europe/London
	  - DEFAULT_WORKSPACE=/config/workspace
	volumes:
	  - /config:/config
	ports:
	  - 8443:8443
	restart: unless-stopped
	deploy:
	resources:
		reservations:
			devices:
				- driver: nvidia
				count: 1
				capabilities: [gpu]
```
