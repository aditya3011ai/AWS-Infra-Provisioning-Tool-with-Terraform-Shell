#!/bin/bash
echo "WARNING: This will destroy all infrastructure provisioned by Terraform."
read -p "Are you sure? (yes/no): " confirm

if [ "$confirm" == "yes" ]; then
  terraform destroy -var-file="terraform.tfvars" -auto-approve
else
  echo "Destroy cancelled."
fi
