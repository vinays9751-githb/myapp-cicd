#!/bin/bash

echo "Logging in to Amazon ECR..."

aws ecr get-login-password --region us-east-2 | \
docker login --username AWS --password-stdin 278396816876.dkr.ecr.us-east-2.amazonaws.com

echo "Stopping existing container..."

docker stop my-app-web-container || true

echo "Removing existing container..."

docker rm my-app-web-container || true

echo "Removing old image..."

docker rmi 278396816876.dkr.ecr.us-east-2.amazonaws.com/my-app-web:latest || true

echo "Pulling latest image from ECR..."

docker pull 278396816876.dkr.ecr.us-east-2.amazonaws.com/my-app-web:latest

echo "Starting new container..."

docker run -d \
--name my-app-web-container \
-p 80:5000 \
278396816876.dkr.ecr.us-east-2.amazonaws.com/my-app-web:latest

echo "Deployment completed successfully."
