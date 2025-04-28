#!/bin/bash

# Exit on error
set -e

# Navigate to app directory
cd /home/ec2-user/app

# Install dependencies
npm install

# Build the application
npm run build

# Set proper permissions
sudo chown -R ec2-user:ec2-user /home/ec2-user/app
sudo chmod -R 755 /home/ec2-user/app 