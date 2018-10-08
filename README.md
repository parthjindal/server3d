# RoboCup 3D Soccer Simulation in Docker

This repository provides Dockerfiles and tools to easily run the
[SimSpark based RoboCup 3D Soccer Simulation
server](https://gitlab.com/robocup-sim/SimSpark) and related
applications. At the moment this consists of the following images:

* rcssserver3d - runs by default the `rcssserver3d` server, can also
  be used to run example agent, and possibly as a base for other
  SimSpark based simulations.
* roboviz - runs the
  [RoboViz](https://github.com/magmaOffenburg/RoboViz) visualization
  tool.

## Quickstart

A Docker compose file is provided to quickly bring up the simulation
server and RoboViz:

    docker-compose up

The RoboViz image requires the [NVIDIA Container Runtime
(`nvidia-docker2`)](https://github.com/NVIDIA/nvidia-docker).

## Advanced Usage

There are two main ways to run your own agents and have them
communicate with the server:

### 1. Run in a container with docker compose

Create a Docker image for your agents. You can then copy the provided
Docker compose file and add an additional service for your agents. As
an example, you can add the following service to run the example agent
provided with the server:

      rcssagent3d:
        image: rcss3d/rcssserver3d:latest
        entrypoint: rcssagent3d
        command: ["--host=rcssserver3d"]
        depends_on:
          - rcssserver3d

### 2. Run agents natively

If you have your agents compiled natively on your host machine, you
have to run the server with ports published to your host. This can be
done by using the `run.sh` scripts provided along with the Docker
files:

    cd rcsserver3d && ./run.sh
    [ new terminal ]
    cd roboviz && ./run.sh

The server's ports 3100 and 3200 are then reachable on the local host.

## Troubleshooting

### RoboViz can't connect to X11 window server

You may have to allow the docker user to connect to the X11 server,
which can be done by running:

    xhost +"local:docker@"

When finished, you can remove this permission again by running:

    xhost -"local:docker@"
