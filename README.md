# AWS Infra Provisioning Tool with Terraform & Shell Project

## 🎯 **Project Idea / Overview**

> "This project is a CLI-based automation tool that provisions a full infrastructure on AWS using Terraform and Shell scripting. It sets up an EC2 instance for hosting applications, an RDS MySQL database for storing data, an S3 bucket for storage/backups, and optional CloudWatch alarms for monitoring. Everything is automated end-to-end using a simple shell script."
> 

## ❓ Why did you build this project?

> "As a DevOps engineer, our primary responsibility is to automate infrastructure provisioning and manage infrastructure as code. I built this project to demonstrate how we can automate AWS resource creation using Terraform and shell scripting without relying on the manual AWS Console."
> 

Reasons:

- Manual provisioning is slow and error-prone
- Terraform ensures **repeatability**, **version control**, and **team collaboration**
- Shell scripting ties it all into a **single-click deployment**
- It showcases **real-world AWS + automation + monitoring** experience

## 💻 What technologies did you use and why?

| Tool/Service | Why Used |
| --- | --- |
| **Terraform** | To define and manage infrastructure as code (IAC) |
| **AWS EC2** | To host a sample application or server |
| **AWS RDS (MySQL)** | To simulate a production-grade database |
| **AWS S3** | To store static files or backups |
| **CloudWatch** | To monitor system metrics like CPU utilization |
| **Shell Script** | To automate Terraform execution (init, plan, apply) |
| **Git** | For version control and collaboration |
| **AWS CLI** | To interact with AWS from the terminal |

---

## 🔥 What features does the project include?

- Provisioning EC2, RDS, S3 using Terraform
- A shell script that runs the whole setup automatically
- Reusable variables and outputs in Terraform
- CloudWatch alarm to monitor CPU usage
- Compatible with **AWS Free Tier**
- Easily **destroy and recreate** infrastructure
- Works with **GitHub repo and CI/CD** (if extended)
