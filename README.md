# flexget
Just the orginal Dockerfile from https://flexget.com/InstallWizard/SynologyNAS/Docker

### Dockerfile
```
FROM     python:3.6-alpine

ARG      PUID

# Create a user to run the application
RUN      adduser -D -u ${PUID} flexget
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
Make a note of the current version of FlexGet on PyPI (we’ll use this to label the image we create). At time of writing, this is 2.20.25.  
Navigate into the directory containing the files above. To build your image, run the following command (don’t forget to substitute in your docker user’s UID):

```
docker build --build-arg PUID=1000 -t flexget:2.20.25 .
```

### Docker run
```
docker run -d \
  --env "TZ=Europe/Copenhagen" \
  --name flexget \
  --restart unless-stopped \
  --volume /volume1/docker/flexget:/home/flexget/.flexget \
  flexget:2.20.25
```
