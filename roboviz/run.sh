#!/usr/bin/env bash

XSOCK=/tmp/.X11-unix
XAUTH=/home/$USER/.Xauthority

if [ -z "$NETWORK" ]; then
    NETWORK=host
fi

docker run \
       --runtime nvidia \
       -it --rm \
       --volume=$XSOCK:$XSOCK:rw \
       --volume=$XAUTH:/root/.Xauthority:rw \
       --env="XAUTHORITY=/root/.Xauthority" \
       --env="DISPLAY=${DISPLAY}" \
       --network $NETWORK \
       rcss3d/roboviz:latest $@
