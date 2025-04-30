# 🚀 Node.js Backend Deployment on AWS EC2 with CI/CD

This repository hosts a simple Node.js backend featuring a test API. The application is containerized using Docker and deployed on an AWS EC2 instance. Continuous Integration and Continuous Deployment (CI/CD) are managed through AWS CodeBuild and CodeDeploy.

---

## 🧰 Tech Stack

- **Backend:** Node.js
- **Containerization:** Docker
- **Deployment:** AWS EC2
- **CI/CD:** AWS CodeBuild & AWS CodeDeploy
- **Version Control:** GitHub

---

## 📁 Project Structure

demo/ <br>
    ├── src/<br>
       └── index.js <br>
    ├── deploy.sh<br>
    ├── Dockerfile <br>
    ├── docker-compose.yml <br>
    ├── appspec.yml <br>
    ├── buildspec.yml <br>
    └── README.md<br>

---

## 🛠️ Setup Instructions

### 1. Prerequisites

- **AWS EC2 Instance:** Ensure you have an EC2 instance running Amazon Linux 2.
- **IAM Roles:** Create IAM roles with appropriate permissions for CodeBuild and CodeDeploy.
- **S3 Bucket:** Set up an S3 bucket to store deployment artifacts.
- **GitHub Repository:** Your source code should be hosted on GitHub.

### 2. Clone the Repository

SSH into your EC2 instance and clone the repository:

```bash
git clone https://github.com/rahulparmar8189/demo.git /home/ec2-user/app/
```


### 3. Docker Setup on EC2

```bash
#!/bin/bash
set -e

# Update packages and install Docker
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Set permissions and deploy
cd /home/ec2-user/app/
sudo chown -R ec2-user:ec2-user .
git config --global --add safe.directory /home/ec2-user/app/
docker-compose down
git pull origin main --rebase
docker-compose build
docker-compose up -d
```

### 4. Test API Endpoint
After deployment, test the API:
http://3.109.206.203:3000/api/test

Expected response:
{
  "success": true,
  "message": "API working fine.",
  "timestamp": "2025-04-30T07:23:35.283Z"
}

### 5. CI/CD Pipeline Configuration
- CodeBuild
  - The buildspec.yml file defines the build process

- CodeDeploy
  - The appspec.yml file outlines the deployment instructions


### 6. 🔄 CI/CD Workflow
- CodeCommit: Push changes to the main branch on GitHub.

- CodeBuild Trigger: AWS CodeBuild is triggered via a webhook.

- Artifact Upload: CodeBuild packages and uploads artifacts to the specified S3 bucket.

- CodeDeploy Execution: AWS CodeDeploy deploys the new version to the EC2 instance.

- Application Restart: The install.sh script rebuilds and restarts the Docker containers.





👨‍💻 Author </br>
Rahul Parmar </br>
GitHub: rahulparmar8189 </br>
