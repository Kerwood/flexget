FROM     python:3.6-alpine

ARG      DOCKER_UID

# Create a user to run the application
RUN      adduser -D -u ${DOCKER_UID} flexget
WORKDIR  /home/flexget

# Data and config volumes
VOLUME   /home/flexget/.flexget
VOLUME   /home/flexget/torrents

# Install FlexGet
RUN      pip3 install -U pip && pip3 install flexget

# Add start script
COPY     start.sh /home/flexget/
RUN      chmod +x ./start.sh

USER     flexget
CMD      ["./start.sh"]