Project - Event-Driven Self-Healing Infrastructure on AWS

An automated cloud remediation system built with Terraform and AWS that detects high CPU utilization on EC2 instances and triggers recovery actions through EventBridge and Lambda, while notifying operators via SNS. This project demonstrates real-world DevOps, GitOps and DevSecOps practices used in production cloud environments.

#What This Project Does

- Monitors EC2 CPU metrics via CloudWatch.
- Triggers EventBridge rules when thresholds are breached.
- Invokes Lambda to reboot EC2 instances and restart Flask services.
- Sends incident and recovery notifications using SNS email.
- Uses Terraform for full Infrastructure-as-Code.
- Runs CI pipelines in GitHub Actions for validation, planning and security scanning.
- Performs IaC security checks using Checkov.

#Architecture Overview

```
EC2 Instance
     ↓
CloudWatch Metrics
     ↓
EventBridge Rule
     ↓
Lambda Auto-Remediation
     ↓
SNS Notification Email
```

Control plane is serverless; workload runs on EC2 — making this a hybrid, event-driven cloud automation system.

#Tech Stack

- Terraform
- AWS EC2
- AWS Lambda
- Amazon EventBridge
- Amazon CloudWatch
- Amazon SNS
- GitHub Actions
- Checkov (IaC Security Scanning)
- Python

#Repository Structure

```
.
├── terraform/
│   ├── cloudwatch.tf
│   ├── eventbridge.tf
│   ├── iam.tf
│   ├── lambda.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── sns.tf
│   └── lambda/
│        └── lambda_aiops.py
├── .github/workflows/
│   └── terraform-ci.yml
└── README.md
```

#How to Run Locally

#Configure AWS credentials
```bash
aws configure
```
#Initialize Terraform
```bash
cd terraform
terraform init
```
#Preview changes
```bash
terraform plan
```
#Deploy
```bash
terraform apply
```

#CI/CD Pipeline

Every push or pull request triggers GitHub Actions which run terraform init, terraform fmt, terraform validate, terraform plan and Checkov security scan. Security findings are reported but do not block builds (temporary configuration for demo purposes).

#DevSecOps Practices

- IaC scanning with Checkov
- Secrets stored securely using GitHub Actions Secrets
- IAM least-privilege principles applied
- Logging and alerting enabled
- GitOps-style workflows

#Future Enhancements

- CloudWatch Dashboards for observability
- Terraform modules and environments
- Approval-based CD pipelines
- GitHub → AWS OIDC authentication
- Step Functions orchestration
- Auto-scaling remediation logic
- Cost monitoring and budgets
- Remote Terraform backend (S3 + DynamoDB)

#Author

Parth Shinde  
GitHub: https://github.com/Parth-Shinde8
