#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

FIREFOX_INSTALL='/usr/lib/firefox'

mkdir -p "${FIREFOX_INSTALL}"

echo "Install Firefox ${FIREFOX_VERS}"
wget -qO- http://releases.mozilla.org/pub/firefox/releases/${FIREFOX_VERS}/linux-x86_64/en-US/firefox-${FIREFOX_VERS}.tar.bz2 | tar xvj --strip 1 -C "${FIREFOX_INSTALL}"

# symlink firefox's binary into usr bin
ln -s "${FIREFOX_INSTALL}"/firefox /usr/bin/firefox
