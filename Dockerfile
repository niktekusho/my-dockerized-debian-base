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
	STARTUP_DIR=/startup \
	INST_SCRIPTS=/inst_scripts \
	NO_VNC_HOME=/home/user/noVNC \
	DEBIAN_FRONTEND=noninteractive \
	VNC_COL_DEPTH=24 \
	VNC_RESOLUTION=1560x1080 \
	VNC_PW=vncpassword \
	VNC_VIEW_ONLY=false \
	FIREFOX_VERS=65.0.2

COPY ./scripts/install ${INST_SCRIPTS}
COPY ./scripts/startup ${STARTUP_DIR}

WORKDIR ${INST_SCRIPTS}

RUN ./install_core.sh

RUN ./locales.sh

# Install xvnc-server & noVNC - HTML5 based VNC viewer
RUN ./install_vnc.sh

# Install firefox
RUN ./install_firefox.sh

# Install graphical env
RUN ./install_de.sh

# Fix permissions for user "user"
RUN ./fix_permissions.sh

USER user

# "Init" script
ENTRYPOINT ["/startup/vnc_startup.sh"]

CMD ["--wait"]
