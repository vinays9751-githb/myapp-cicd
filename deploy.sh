#!/bin/bash

echo "Logging in to Amazon ECR..."

aws ecr get-login-password --region us-east-2 | \
docker login --username AWS --password-stdin 278396816876.dkr.ecr.us-east-2.amazonaws.com

echo "Stopping existing container..."

docker stop myapp-container || true

echo "Removing existing container..."

docker rm myapp-container || true

echo "Removing old image..."

docker rmi 278396816876.dkr.ecr.us-east-2.amazonaws.com/myapp:latest || true

echo "Pulling latest image from ECR..."

docker pull 278396816876.dkr.ecr.us-east-2.amazonaws.com/myapp:latest

echo "Starting new container..."

docker run -d \
--name myapp-container \
-p 80:5000 \
278396816876.dkr.ecr.us-east-2.amazonaws.com/myapp:latest

echo "Deployment completed successfully."
