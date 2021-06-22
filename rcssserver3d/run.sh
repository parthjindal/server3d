#!/usr/bin/bash

if [ -z "$NETWORK" ]; then
    NETWORK=host
fi

source_dir=$1
docker run \
       --network $NETWORK \
       -d -it --rm \
       --name rcssserver3d \
       --mount type=bind,source=$source_dir,target=/app \
       parthjindal/rcssserver3d:latest

