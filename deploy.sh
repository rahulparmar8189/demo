#!/bin/bash

# Exit on error
set -e

# Update system packages
sudo yum update -y

# Install Docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Create app directory
mkdir -p /home/ec2-user/app
echo "App directory created"

# Set permissions
sudo chown -R ec2-user:ec2-user /home/ec2-user/app

# Deploy application
cd /home/ec2-user/app

# Ensure docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
  echo "docker-compose.yml not found!"
  exit 1
fi

echo "Starting application..."
docker-compose up -d
