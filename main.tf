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
resource "aws_db_instance" "devops_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "devopsdb"
  username             = "admin"
  password             = "DevOps123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}
resource "aws_security_group" "db_sg" {
  name        = "allow_ec2_to_rds"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ssh_access.id] # allow EC2 SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

