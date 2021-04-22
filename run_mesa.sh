#!/usr/bin/bash

# generate xauth cookies
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -

while test $# -gt 0; do
    case "$1" in
    -h | --help)
        echo "options:"
        echo "-h, --help             show brief help"
        echo "-a, --agent_port       specify agent_port"
        echo "-s, --server_port      specify server_port"
        echo "--server               If set,only starts rcssserver"
        echo "--monitor              If set,only starts monitor"
        exit 0
        ;;
    -a | --agent_port)
        shift
        AGENT_PORT=$1
        ;;
    -s | --server_port)
        shift
        SERVER_PORT=$1
        ;;
    --server)
        service="$service rcssserver3d"
        ;;
    --monitor)
        service="$service roboviz"
        ;;
    --*)
        echo "bad option $1"
        ;;
    esac
    shift
done

SERVER_PORT=${SERVER_PORT:-3200}
AGENT_PORT=${AGENT_PORT:-3100}
service=${service:-rcssserver3d roboviz}

export SERVER_PORT
export AGENT_PORT

docker-compose -f docker-compose.mesa.yml up $service
