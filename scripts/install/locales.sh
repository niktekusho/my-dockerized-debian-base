#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

export LC_ALL=en_US.utf8 LANGUAGE=en_US.utf8 LANG=en_US.utf8
