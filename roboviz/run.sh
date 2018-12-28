#!/usr/bin/env bash

GFX=$1
shift

if [ "x$GFX" = "x" ]; then
    echo "Usage: run.sh mesa|nvidia"
    exit 1
fi

if [ "$GFX" = "nvidia" ]; then
    RUNTIME="--runtime nvidia"
else
    RUNTIME=
fi

XSOCK=/tmp/.X11-unix
XAUTH=/home/$USER/.Xauthority

if [ -z "$NETWORK" ]; then
    NETWORK=host
fi

docker run \
       $RUNTIME \
       -it --rm \
       --volume=$XSOCK:$XSOCK:rw \
       --volume=$XAUTH:/root/.Xauthority:rw \
       --env="XAUTHORITY=/root/.Xauthority" \
       --env="DISPLAY=${DISPLAY}" \
       --network $NETWORK \
       rcss3d/roboviz:$GFX-latest $@
