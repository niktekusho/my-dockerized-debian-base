[![](https://images.microbadger.com/badges/version/nikgatto/my-dockerized-debian-base.svg)](https://hub.docker.com/r/nikgatto/my-dockerized-debian-base/) [![](https://images.microbadger.com/badges/image/nikgatto/my-dockerized-debian-base.svg)](http://microbadger.com/images/nikgatto/my-dockerized-debian-base)

# My Dockerized Debian Base

This repository contains a Debian Docker image with a headless VNC environment.

I provide this base image with the following components:

* **Unconfigured** Desktop environment [**Xfce4**](http://www.xfce.org)
* VNC-Server (default VNC port `5901`)
* [**noVNC**](https://github.com/novnc/noVNC) - HTML5 VNC client (default http port `6901`)
* Mozilla Firefox
* Some CLI utilities

**This project is heavily based on [ConSol Headless VNC Docker images](https://github.com/ConSol/docker-headless-vnc-container).**

## Usage

Get it up and running with:

```sh
 $ docker run -d -p 5901:5901 -p 6901:6901 nikgatto/my-dockerized-debian-base
```

The above command spawns a new container with mapping to local port `5901` (vnc protocol) and `6901` (vnc web access).
If the container is started like mentioned above, connect via one of these options:

* connect via __VNC viewer `localhost:5901`__, default password: `vncpassword`
* connect via __noVNC HTML5 full client__: [`http://localhost:6901/vnc.html`](http://localhost:6901/vnc.html), default password: `vncpassword`
* connect via __noVNC HTML5 lite client__: [`http://localhost:6901/?password=vncpassword`](http://localhost:6901/?password=vncpassword)

### Help

Print out some help info:

```sh
 $ docker run nikgatto/my-dockerized-debian-base -h
```

### Interactive Mode

If you want to get into the container, use interactive mode `-it` and `bash`

```sh
 $ docker run -p 5901:5901 -p 6901:6901 nikgatto/my-dockerized-debian-base bash
```

## Build Docker image from source

Clone this repository, then build with:

```sh
 $ docker build -t nikgatto/my-dockerized-debian-base .
```

## Advanced usage

### Extending this image

This image runs as non-root user by default.
If you want to extend the image and install software, you have to switch back to the `root` user:

```sh
## Custom Dockerfile
FROM nikgatto/my-dockerized-debian-base

# Switch to root user to install additional software
USER root

## Install a gedit
RUN apt-get update && apt-get install <something>

## switch back to default user
USER user
```

### Override VNC environment variables

The following VNC environment variables can be overwritten at the `docker run` phase to customize your desktop environment inside the container:

* `VNC_COL_DEPTH`, default: `24`
* `VNC_RESOLUTION`, default: `1280x1024`
* `VNC_PW`, default: `my-pw`

#### Example: Override the VNC password

Simply overwrite the value of the environment variable `VNC_PW`. Use the `-e` like in the command example below (`-e ENV_NAME=ENV_VALUE`):

```sh
 $ docker run -it -p 5901:5901 -p 6901:6901 -e VNC_PW=my-pw nikgatto/my-dockerized-debian-base
```

#### View only VNC

You can prevent unwanted control via VNC: you need to set the environment variable `VNC_VIEW_ONLY=true`.
If set, the startup script will create a random password for the control connection and use the value of `VNC_PW` for view only connection over the VNC connection.

```sh
 $ docker run -it -p 5901:5901 -p 6901:6901 -e VNC_VIEW_ONLY=true nikgatto/my-dockerized-debian-base
```

## Known Issues

### Chromium crashes with high VNC_RESOLUTION ([#53](https://github.com/ConSol/docker-headless-vnc-container/issues/53))

If you open some graphic/work intensive websites in the Docker container (especially with high resolutions e.g. `1920x1080`) it can happen that Chromium crashes without any specific reason. The problem there is the too small `/dev/shm` size in the container. Currently there is no other way, as define this size on startup via `--shm-size` option, see [#53 - Solution](https://github.com/ConSol/docker-headless-vnc-container/issues/53#issuecomment-347265977):

    docker run --shm-size=256m -it -p 6901:6901 -e VNC_RESOLUTION=1920x1080 consol/centos-xfce-vnc chromium-browser http://map.norsecorp.com/

Thx @raghavkarol for the hint!
