variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2"
  default     = "ami-0f918f7e67a3323f0" 
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}
