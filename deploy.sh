#!/bin/bash
set -e

# Update and install Docker
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Clone repo if not already present
if [ ! -d "/home/ec2-user/app/demo/.git" ]; then
  git clone https://your-repo-url.git /home/ec2-user/app/demo
fi

# Set ownership
sudo chown -R ec2-user:ec2-user /home/ec2-user/app/demo

cd /home/ec2-user/app/demo

# Check docker-compose.yml
if [ ! -f "docker-compose.yml" ]; then
  echo "docker-compose.yml not found!"
  exit 1
fi

echo "Starting application..."
docker stop $(docker ps -q)
docker rm $(docker ps -aq)
docker rmi -f $(docker images -q)
git config --global --add safe.directory /home/ec2-user/app/demo
git pull origin main --rebase
docker-compose build
docker-compose up -d
