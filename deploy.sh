#!/bin/bash

MACHINE="default"
FILE="./docker-compose.yml"

if [ -z "$1" ]; then
  echo "Missing Machine name"
else
  MACHINE=$1
fi

if [ -z "$2" ]; then
  echo "Using default compose file"
else
  FILE=$2
fi

HOST_IP=`docker-machine ip`

eval "$(docker-machine env $MACHINE)"

eval "$(docker-compose -f $FILE build)"
eval "$(docker-compose -f $FILE up)""
