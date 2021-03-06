#!/bin/bash

mkdir ../git-source
mkdir ../git-source/cdsp-core
mkdir ../git-source/cdsp-discovery-services
mkdir ../git-source/cdsp-location-services
mkdir ../git-source/cdsp-mdn-services
mkdir ../git-source/cdsp-payment-services
mkdir ../git-source/cdsp-security-services
mkdir ../git-source/cdsp-tenant-services
mkdir ../git-source/cdsp-replica-services

# Set up Repos
git clone https://github.com/monsterstack/core-server.git -b development ../git-source/cdsp-core/core-server
git clone https://github.com/monsterstack/core-worker.git -b development ../git-source/cdsp-core/core-worker

git clone https://github.com/monsterstack/multi-tenancy-db.git -b development ../git-source/cdsp-core/multi-tenancy-db
git clone https://github.com/monsterstack/stash.git -b development ../git-source/cdsp-core/stash

git clone https://github.com/monsterstack/replica-service.git -b development ../git-source/cdsp-replica-services/replica-service

git clone https://github.com/monsterstack/discovery-client.git -b development ../git-source/cdsp-discovery-services/discovery-client
git clone https://github.com/monsterstack/discovery-model.git -b development ../git-source/cdsp-discovery-services/discovery-model
git clone https://github.com/monsterstack/discovery-proxy.git -b development ../git-source/cdsp-discovery-services/discovery-proxy
git clone https://github.com/monsterstack/discovery-middleware.git -b development ../git-source/cdsp-discovery-services/discovery-middleware
git clone https://github.com/monsterstack/generator-service-gen.git -b development ../git-source/cdsp-discovery-services/generator-service-gen
git clone https://github.com/monsterstack/discovery-service.git -b development ../git-source/cdsp-discovery-services/discovery-service
git clone https://github.com/monsterstack/discovery-test-tools.git -b development ../git-source/cdsp-discovery-services/discovery-test-tools
git clone https://github.com/monsterstack/discovery-health-worker.git -b development ../git-source/cdsp-discovery-services/discovery-health-worker

git clone https://github.com/monsterstack/location-service.git -b development ../git-source/cdsp-location-services/location-service

git clone https://github.com/monsterstack/mdn-service.git -b development ../git-source/cdsp-mdn-services/mdn-service
git clone https://github.com/monsterstack/mdn-email-worker.git -b development ../git-source/cdsp-mdn-services/mdn-email-worker
git clone https://github.com/monsterstack/mdn-sms-worker.git -b development ../git-source/cdsp-mdn-services/mdn-sms-worker
git clone https://github.com/monsterstack/mdn-web-worker.git -b development ../git-source/cdsp-mdn-services/mdn-web-worker
git clone https://github.com/monsterstack/mdn-push-worker.git -b development ../git-source/cdsp-mdn-services/mdn-push-worker

git clone https://github.com/monsterstack/payment-service.git -b development ../git-source/cdsp-payment-services/payment-service

git clone https://github.com/monsterstack/security-service.git -b development ../git-source/cdsp-security-services/security-service
git clone https://github.com/monsterstack/security-model.git -b development ../git-source/cdsp-security-services/security-model

git clone https://github.com/monsterstack/tenant-model.git -b development ../git-source/cdsp-tenant-services/tenant-model
git clone https://github.com/monsterstack/tenant-middleware.git -b development ../git-source/cdsp-tenant-services/tenant-middleware

git clone https://github.com/monsterstack/tenant-service.git -b development ../git-source/cdsp-tenant-services/tenant-service
