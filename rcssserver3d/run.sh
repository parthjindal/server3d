#!/usr/bin/env bash

if [ -z "$NETWORK" ]; then
    NETWORK=host
fi

docker run \
       --network $NETWORK \
       -ti --rm \
       --name rcssserver3d \
       rcss3d/rcssserver3d:latest $@

