#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Building default version in Dockerfile and tagging as 'latest'"
    ARGS=
    TAG=latest
else
    echo "Building and tagging version: $1"
    ARGS="--build-arg RCSSSERVER3D_RELEASE=$1"
    TAG=$1
fi

docker build $ARGS -t rcss3d/rcssserver3d:$TAG .
