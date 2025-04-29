#!/bin/bash

# Exit on error
set -e

# Navigate to app directory
cd /home/ec2-user/app

# Start the application using Docker Compose
docker-compose down
docker stop $(docker ps -q)
docker rm $(docker ps -a -q)
git pull origin main
sleep 10
docker build -t my-node-app .
sleep 10
docker-compose up -d

# Wait for the application to start
sleep 10

# Check if the application is running
if ! docker-compose ps | grep -q "Up"; then
    echo "Error: Application failed to start"
    exit 1
fi 