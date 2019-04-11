# This is a wild attempt to reduce the image from https://github.com/ConSol/docker-headless-vnc-container

# 9 -> "Stretch"
FROM debian:9.8-slim

ENV DISPLAY=:1 \
	VNC_PORT=5901 \
	NO_VNC_PORT=6901

# Expose ports for both noVNC and normal VNC Server
EXPOSE $VNC_PORT $NO_VNC_PORT

# User creation and permissions fix
RUN useradd --create-home --shell /bin/bash user

# Other envs
ENV HOME=/home/user \
	TERM=xterm \
	CONFIG_DIR=/configs \
	STARTUP_DIR=/startup \
	INST_SCRIPTS=/inst_scripts \
	NO_VNC_HOME=/home/user/noVNC \
	DEBIAN_FRONTEND=noninteractive \
	VNC_COL_DEPTH=24 \
	VNC_RESOLUTION=1350x900 \
	VNC_PW=vncpassword \
	VNC_VIEW_ONLY=false \
	FIREFOX_VERS=65.0.2

COPY ./scripts/startup ${STARTUP_DIR}

COPY ./configs ${CONFIG_DIR}

# Trying to use the Docker build cache in a smarter way: COPY FILES AS NEEDED!
# This makes edits to a file invalidate only the cache from the step it's copied at the cost of having more steps.
# Before I copied all files in an initial step (1 vs many COPY steps), invalidating cache from the COPY step all the way to the end.
COPY ./scripts/install/install_core.sh ${INST_SCRIPTS}/
WORKDIR ${INST_SCRIPTS}
RUN ./install_core.sh

COPY ./scripts/install/locales.sh ${INST_SCRIPTS}/
RUN ./locales.sh

# Install xvnc-server & noVNC - HTML5 based VNC viewer
COPY ./scripts/install/install_vnc.sh ${INST_SCRIPTS}/
RUN ./install_vnc.sh

# Install and config firefox
COPY ./scripts/install/install_firefox.sh ${INST_SCRIPTS}/
RUN ./install_firefox.sh

# Install graphical env
COPY ./scripts/install/install_de.sh ${INST_SCRIPTS}/
RUN ./install_de.sh

# Fix permissions for user "user"
COPY ./scripts/install/fix_permissions.sh ${INST_SCRIPTS}/
RUN ./fix_permissions.sh

USER user

# "Init" script
# ENTRYPOINT ["/startup/vnc_startup.sh"]

# CMD ["--wait"]
