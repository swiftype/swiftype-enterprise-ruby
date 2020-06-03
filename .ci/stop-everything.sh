#!/bin/bash

set -x

# Stop all stack components
docker-compose -f docker-compose.yml down --timeout 10
