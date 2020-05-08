FROM     python:3.8-alpine

ARG      PUID

# Create a user to run the application
RUN      adduser -D -u ${PUID} flexget
WORKDIR  /home/flexget

# Data and config volumes
VOLUME   /home/flexget/.flexget
VOLUME   /home/flexget/torrents

# Install FlexGet
RUN      pip3 install -U pip && pip3 install 'flexget>=3.0.0,<4.0.0'

# Add start script
COPY     start.sh /home/flexget/
RUN      chmod +x ./start.sh

USER     flexget
CMD      ["./start.sh"]
