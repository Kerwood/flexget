# flexget v.3
Just the orginal Dockerfile from https://flexget.com/InstallWizard/SynologyNAS/Docker

### Dockerfile
```
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
```

### start.sh
```
#!/bin/sh
if [ -f ~/.flexget/.config-lock ]; then
    rm ~/.flexget/.config-lock
fi
flexget daemon start
```
### Build
Navigate into the directory containing the files above. To build your image, run the following command (don’t forget to substitute in your user’s UID):

```
docker build --build-arg PUID=1000 -t flexget:3 .
```

### Docker run
```
docker run -d \
  --env "TZ=Europe/Copenhagen" \
  --name flexget \
  --restart unless-stopped \
  --volume /volume1/docker/flexget:/home/flexget/.flexget \
  flexget:3
```
