# #!/bin/bash
# set -e

# cd /home/ec2-user/app

# # Bring down old containers (if any)
# docker-compose down

# # Build and run containers
# docker-compose up --build -d

# # Wait and verify
# echo "Waiting for application to start..."
# sleep 10

# if ! docker-compose ps | grep -q "Up"; then
#     echo "Error: Application failed to start"
#     exit 1
# fi

echo "In the start_application file..."