#!/bin/bash

mkdir ./git-source
mkdir ./git-source/cdsp-core
mkdir ./git-source/cdsp-discovery-services
mkdir ./git-source/cdsp-location-services
mkdir ./git-source/cdsp-mdn-services
mkdir ./git-source/cdsp-payment-services
mkdir ./git-source/cdsp-security-services
mkdir ./git-source/cdsp-tenant-services

# Set up Repos
git clone https://github.com/zacharyrote/core-server.git -b development ./git-source/cdsp-core/core-server
git clone https://github.com/zacharyrote/discovery-client.git -b development ./git-source/cdsp-discovery-services/discovery-client
git clone https://github.com/zacharyrote/discovery-model.git -b development ./git-source/cdsp-discovery-services/discovery-model
git clone https://github.com/zacharyrote/discovery-proxy.git -b development ./git-source/cdsp-discovery-services/discovery-proxy
git clone https://github.com/zacharyrote/discovery-service.git -b development ./git-source/cdsp-discovery-services/discovery-service

git clone https://github.com/zacharyrote/location-service.git -b development ./git-source/cdsp-location-services/location-service

git clone https://github.com/zacharyrote/mdn-service.git -b development ./git-source/cdsp-mdn-services/mdn-service

git clone https://github.com/zacharyrote/payment-service.git -b development ./git-source/cdsp-location-services/payment-service

git clone https://github.com/zacharyrote/security-service.git -b development ./git-source/cdsp-security-services/security-service

git clone https://github.com/zacharyrote/tenant-model.git -b development ./git-source/cdsp-tenant-services/tenant-model
git clone https://github.com/zacharyrote/tenant-service.git -b development ./git-source/cdsp-tenant-services/tenant-service
