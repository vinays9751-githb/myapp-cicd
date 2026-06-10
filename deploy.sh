#!/bin/bash

# Login to Amazon ECR
aws ecr get-login-password --region us-east-2 | \
docker login --username AWS --password-stdin 278396816876.dkr.ecr.us-east-2.amazonaws.com

# Stop old container
docker stop myapp-container || true

# Remove old container
docker rm myapp-container || true

# Remove old image
docker rmi 278396816876.dkr.ecr.us-east-2.amazonaws.com/myapp:latest || true

# Pull latest image
docker pull 278396816876.dkr.ecr.us-east-2.amazonaws.com/myapp:latest

# Run latest container
docker run -d \
-p 80:5000 \
--name myapp-container \
278396816876.dkr.ecr.us-east-2.amazonaws.com/myapp:latest
