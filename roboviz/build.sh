#!/usr/bin/env bash

GFX=$1

if [ -z "$2" ]; then
    echo "Building default version in Dockerfile and tagging as '$GFX-latest'"
    ARGS=
    TAG=latest
else
    echo "Building and tagging version: $GFX-$2"
    ARGS="--build-arg ROBOVIZ_RELEASE=$2"
    TAG=$2
fi

docker build $ARGS -t rcss3d/roboviz:$GFX-$TAG $GFX

