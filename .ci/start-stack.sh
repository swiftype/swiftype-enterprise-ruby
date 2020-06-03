#!/bin/bash

set -ex

# Start stack components
docker-compose -f ./.ci/docker-compose.yml up --detach elasticsearch enterprise-search

# Wait until the product is up and running
until curl --silent --output /dev/null --max-time 1 http://localhost:8080/swiftype-app-version; do
    echo 'Waiting for the stack to start...'
    sleep 5
done
