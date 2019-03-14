#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

echo "Install core packages"
apt-get update

apt-get install -y \
    bzip2 \
    curl \
	git \
	locales \
    nano \
    net-tools \
    wget \
    python-numpy #used for websockify/novnc

# No need since we are using debian slim
# apt-get clean -y
