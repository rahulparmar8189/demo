#!/bin/bash

# Exit on error
set -e

# Navigate to app directory
cd /home/ec2-user/app

# Start the application using Docker Compose
docker-compose down
docker-compose up -d

# Wait for the application to start
sleep 10

# Check if the application is running
if ! docker-compose ps | grep -q "Up"; then
    echo "Error: Application failed to start"
    exit 1
fi 