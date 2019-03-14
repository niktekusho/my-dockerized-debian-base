#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

echo "Giving normal user (non root) permissions"

# Directories in need of user permission fix
DIRS=("${STARTUP_DIR}" "${HOME}")

for dir in ${DIRS[*]}; do
	echo "Working on ${dir}"
	find "${dir}"/ -name '*.sh' -exec chmod a+x {} +
	find "${dir}"/ -name '*.desktop' -exec chmod a+x {} +
	chgrp -v -R user "${dir}" && chmod -v -R a+rw "${dir}" && find "${dir}" -type d -exec chmod a+x {} +
	ls -la "${dir}"
done
