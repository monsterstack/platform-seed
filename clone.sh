#!/bin/bash

mkdir ../git-source
mkdir ../git-source/cdsp-core
mkdir ../git-source/cdsp-discovery-services
mkdir ../git-source/cdsp-location-services
mkdir ../git-source/cdsp-mdn-services
mkdir ../git-source/cdsp-payment-services
mkdir ../git-source/cdsp-security-services
mkdir ../git-source/cdsp-tenant-services

# Set up Repos
git clone https://github.com/monsterstack/core-server.git -b development ../git-source/cdsp-core/core-server
git clone https://github.com/monsterstack/core-worker.git -b development ../git-source/cdsp-core/core-worker

git clone https://github.com/monsterstack/multi-tenancy-db.git -b development ../git-source/cdsp-core/multi-tenancy-db

git clone https://github.com/monsterstack/discovery-client.git -b development ../git-source/cdsp-discovery-services/discovery-client
git clone https://github.com/monsterstack/discovery-model.git -b development ../git-source/cdsp-discovery-services/discovery-model
git clone https://github.com/monsterstack/discovery-proxy.git -b development ../git-source/cdsp-discovery-services/discovery-proxy
git clone https://github.com/monsterstack/generator-service-gen.git -b development ../git-source/cdsp-discovery-services/generator-service-gen
git clone https://github.com/monsterstack/discovery-service.git -b development ../git-source/cdsp-discovery-services/discovery-service

git clone https://github.com/monsterstack/location-service.git -b development ../git-source/cdsp-location-services/location-service

git clone https://github.com/monsterstack/mdn-service.git -b development ../git-source/cdsp-mdn-services/mdn-service

git clone https://github.com/monsterstack/payment-service.git -b development ../git-source/cdsp-payment-services/payment-service

git clone https://github.com/monsterstack/security-service.git -b development ../git-source/cdsp-security-services/security-service
git clone https://github.com/monsterstack/security-model.git -b development ../git-source/cdsp-security-services/security-model

git clone https://github.com/monsterstack/tenant-model.git -b development ../git-source/cdsp-tenant-services/tenant-model
git clone https://github.com/monsterstack/tenant-service.git -b development ../git-source/cdsp-tenant-services/tenant-service
