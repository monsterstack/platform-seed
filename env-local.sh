#!/bin/bash

UNAME=`uname`

if [[ "$UNAME" == "Darwin" ]]; then
    IP=`ipconfig getifaddr en0`
else
    IP=`hostname --ip-address`
fi

echo $UNAME - $IP

export HOST_IP=$IP
export RETHINK_HOST_IP=$IP
export REDIS_HOST_IP=$IP
export MONGO_HOST_IP=$IP
export ETCD_HOST_IP=$IP
export DISCOVERY_HOST_IP=$IP

# Remove current line with hostname at the end of line ($ means end of line)
sed '/etcd.digitalfunk.io/d' /etc/hosts 
sed '/etcd.digitalfunk.io/d' /etc/hosts
sed '/mongo.digitalfunk.io/d' /etc/hosts
sed '/redis.digitalfunk.io/d' /etc/hosts
sed '/discovery.digitalfunk.io/d' /etc/hosts

echo "$IP rethink.digitalfunk.io" >>/etc/hosts
echo "$IP etcd.digitalfunk.io" >>/etc/hosts
echo "$IP mongo.digitalfunk.io" >>/etc/hosts
echo "$IP redis.digitalfunk.io" >>/etc/hosts
echo "$IP discovery.digitalfunk.io" >>/etc/hosts
