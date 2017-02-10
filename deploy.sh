#!/bin/bash

MACHINE="default"
DIR="./"

if [ -z "$1" ]; then
  echo "Missing Machine name"
else
  MACHINE=$1
fi

if [ -z "$2" ]; then
  echo "Using default compose file"
else
  DIR=$2
fi

HOST_IP=`docker-machine ip`

eval "$(docker-machine env $MACHINE)"
cd $DIR
eval "$(docker-compose build)"
eval "$(docker-compose up)"

cd -
