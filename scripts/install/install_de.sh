#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

# Original credits to Corey Butts - https://gist.github.com/boreycutts/6417980039760d9d9dac0dd2148d4783

echo "Install i3-gaps"
echo "Dependencies"
apt-get update
# KEEP ALPHABETICAL SORT
apt-get install -y \
	autoconf \
	automake \
	libev-dev \
	libpango1.0-dev \
	libstartup-notification0-dev \
	libtool \
	libxcb-cursor-dev \
	libxcb-icccm4-dev \
	libxcb-keysyms1-dev \
	libxcb-randr0-dev \
	libxcb-util0-dev \
	libxcb-xinerama0-dev \
	libxcb-xkb-dev \
	libxcb-xrm-dev \
	libxcb1-dev \
	libxkbcommon-dev \
	libxkbcommon-x11-dev \
	libyajl-dev \
	xfonts-75dpi \
	xfonts-100dpi \
	xutils-dev \
	x11-xkb-utils

cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
make install

# No need since we are using debian slim
# apt-get clean -y

# Config xfce basic stuff
# echo "Configuring xfce with the default layout"
# TARGET="$HOME/.config/"
# mkdir -p $TARGET
# cp -r "$CONFIG_DIR/xfce4" $TARGET
