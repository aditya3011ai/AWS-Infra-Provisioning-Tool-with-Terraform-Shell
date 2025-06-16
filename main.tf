provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "DevOpsEC2"
  }
}

resource "aws_s3_bucket" "devops_bucket" {
  bucket = "devops-bucket-${random_id.bucket_id.hex}"
  force_destroy = true
  tags = {
    Name = "DevOps Project Bucket"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "HighCPUUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This alarm triggers if CPU exceeds 70%"
  actions_enabled     = true

  alarm_actions = [aws_sns_topic.alert_topic.arn]

  dimensions = {
    InstanceId = aws_instance.web.id
  }
}
resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_sns_topic" "alert_topic" {
  name = "ec2-cpu-alerts"
}
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.alert_topic.arn
  protocol  = "email"
  endpoint  = "aditya3011.1990@gmail.com"  # 👈 Replace with your email
}
