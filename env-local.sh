#!/bin/bash

UNAME=`uname`

if [ $UNAME = 'Darwin']; then
    IP=`ipconfig getifaddr en0`
else
    IP=`hostname --ip-address`
fi

export HOST_IP=$IP
export RETHINK_HOST_IP=$IP
export MONGO_HOST_IP=$IP
export ETCD_HOST_IP=$IP

