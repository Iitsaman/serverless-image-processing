#!/bin/bash
set -euo pipefail

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

# Build Lambda layer using Docker 
echo "📦 Building Lambda layer with Docker..."
chmod +x "$SCRIPT_DIR/build_layer.sh"
bash "$SCRIPT_DIR/build_layer.sh"

# Initialize Terraform
echo "🔧 Initializing Terraform..."
cd "$PROJECT_DIR/terraform"
terraform init

# Plan deployment
echo "📋 Planning Terraform deployment..."
terraform plan -out=tfplan

# Apply deployment
echo "🚀 Applying Terraform deployment..."
terraform apply tfplan

# Get outputs
echo "📊 Getting deployment outputs..."
UPLOAD_BUCKET=$(terraform output -raw upload_bucket_name)
PROCESSED_BUCKET=$(terraform output -raw processed_bucket_name)
LAMBDA_FUNCTION=$(terraform output -raw lambda_function_name)
REGION=$(terraform output -raw region)

