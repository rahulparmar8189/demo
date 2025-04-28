#!/bin/bash

# Exit on error
set -e

# Update system
sudo yum update -y

# Install Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 20

# Install Docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Create app directory if it doesn't exist
mkdir -p /home/ec2-user/app
echo "App directory created"

# Copy application files
if [ -d "/home/ec2-user/app" ]; then
    echo "Copying application files"
    cp -r /home/ec2-user/app/* /home/ec2-user/app/
else
    echo "Inside else"
    echo "Error: Source directory /home/ec2-user/app does not exist"
    exit 1
fi

# Set proper permissions
echo "Setting proper permissions"
sudo chown -R ec2-user:ec2-user /home/ec2-user/app
sudo chmod -R 755 /home/ec2-user/app

# Start application
echo "Starting application"
cd /home/ec2-user/app
docker-compose up -d 