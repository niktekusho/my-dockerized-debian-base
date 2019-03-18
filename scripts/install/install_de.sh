#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

echo "Install Xfce4 UI components"
apt-get update
apt-get -qq install -y supervisor xfce4 xfce4-terminal xterm

# No need since we are using debian slim
# apt-get clean -y

# Config xfce basic stuff
# echo "Configuring xfce with the default layout"
# TARGET="$HOME/.config/"
# mkdir -p $TARGET
# cp -r "$CONFIG_DIR/xfce4" $TARGET
