#!/bin/bash
echo "🔧 Initializing Terraform..."
terraform init

echo "🧠 Validating Terraform code..."
terraform validate

echo "📋 Showing Terraform Plan..."
terraform plan -var-file="terraform.tfvars"

echo "🚀 Applying Terraform configuration..."
terraform apply -var-file="terraform.tfvars" -auto-approve

echo "✅ Infrastructure provisioned successfully!"
