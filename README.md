<div align="center">

# AWS 3-Tier Flask Application
### Production-Grade Cloud Deployment · Terraform IaC · Docker Containerisation

[![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?style=for-the-badge&logo=terraform)](https://www.terraform.io/)
[![Docker](https://img.shields.io/badge/Container-Docker-2496ED?style=for-the-badge&logo=docker)](https://www.docker.com/)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?style=for-the-badge&logo=amazonaws)](https://aws.amazon.com/)
[![Python](https://img.shields.io/badge/Backend-Flask%20%2F%20Python-3776AB?style=for-the-badge&logo=python)](https://flask.palletsprojects.com/)
[![Status](https://img.shields.io/badge/Status-Production%20Deployed-00C853?style=for-the-badge)]()

</div>

---

## Overview

This repository contains the infrastructure code and application source for a **production-representative three-tier web application** deployed on Amazon Web Services. The project demonstrates end-to-end cloud engineering capability — from network architecture and security design through to containerised application deployment, all provisioned via Infrastructure as Code.

The architecture enforces strict layer separation across presentation, application, and data tiers, providing blast-radius containment, independent scaling, and a defence-in-depth security posture consistent with the **AWS Well-Architected Framework**.

---

## Architecture



| Tier | Layer | Placement | Exposure |
|------|-------|-----------|----------|
| **1** | Presentation (Web / Load Balancer) | Public Subnet | Internet-facing |
| **2** | Application (Flask REST API · Docker) | Private Subnet | Internal only |
| **3** | Data (Database) | Private Subnet | Application tier only |

---

## Technology Stack

| Category | Technology | Version |
|---|---|---|
| Cloud Provider | Amazon Web Services | — |
| Infrastructure as Code | Terraform (HCL) | ≥ 1.6 |
| Containerisation | Docker | ≥ 24.x |
| Application Framework | Flask (Python) | 3.x |
| Compute | AWS EC2 | — |
| Networking | AWS VPC + Subnets + SGs + IGW | — |
| Version Control | Git / GitHub | — |
| CI Trigger | GitHub Actions (push-based) | — |

---

## Prerequisites

Ensure the following are installed and authenticated before deployment:

```bash
# Verify toolchain
terraform  version   # ≥ 1.6.0
docker     version   # ≥ 24.x
aws        --version # ≥ 2.x

# Configure AWS credentials
aws configure
# AWS Access Key ID, Secret, Region, Output format
```

---

## Deployment

### 1. Clone Repository

```bash
git clone https://github.com/<your-username>/aws-3tier-flask.git
cd aws-3tier-flask
```

### 2. Provision Infrastructure

```bash
cd infrastructure/

# Initialise Terraform providers and remote state backend
terraform init

# Validate configuration syntax and resource consistency
terraform validate

# Preview execution plan — review before applying
terraform plan -out=tfplan

# Apply approved plan to target AWS environment
terraform apply tfplan
```

### 3. Build and Deploy Application Container

```bash
# Build Docker image from source
docker build -t flask-app:latest ./app

# Run locally for smoke testing
docker run -p 5000:5000 flask-app:latest

# Deploy container to EC2 (SSH into instance first)
ssh -i <key.pem> ec2-user@<EC2_PUBLIC_IP>
docker pull flask-app:latest
docker run -d -p 80:5000 --restart=always flask-app:latest
```

### 4. Teardown

```bash
cd infrastructure/
terraform destroy
```

---

## Repository Structure

```
aws-3tier-flask/
├── infrastructure/           # Terraform IaC
│   ├── main.tf               # Root module — resource orchestration
│   ├── variables.tf          # Input variable declarations
│   ├── outputs.tf            # Output value exports
│   ├── terraform.tfvars      # Environment-specific values (gitignored)
│   └── modules/
│       ├── networking/       # VPC, subnets, IGW, route tables
│       ├── compute/          # EC2 instances, key pairs
│       └── security/         # Security groups, IAM roles
├── app/
│   ├── app.py                # Flask application entry point
│   ├── requirements.txt      # Python dependencies
│   └── Dockerfile            # Container build definition
├── docs/
│   └── architecture.png      # Architecture diagram
└── README.md
```

---

## Security Posture

- **Network segmentation** — application and data tiers are fully isolated in private subnets with no direct internet routing
- **Least-privilege Security Groups** — explicit allow rules only; all other traffic implicitly denied
- **No credentials in source** — AWS credentials and sensitive values managed via environment variables and `terraform.tfvars` (gitignored)
- **Immutable containers** — Docker images are built from a locked base image and never mutated in production

---

## Incidents & Resolutions

Real operational challenges encountered and resolved during this engagement:

| Incident | Root Cause | Resolution |
|---|---|---|
| Docker daemon connection failure | Docker Desktop process crash; socket unavailable | Daemon restart; added pre-build health check |
| Terraform dependency resolution error | Missing `depends_on` declarations; implicit ordering insufficient | Explicit dependency graph; `terraform validate` in CI |
| Security Group ingress misconfiguration | Incorrect CIDR references; missing port rules | VPC Flow Log analysis; least-privilege rule rewrite |


## Author

**Sibonelo Buthelezi** — Cloud / DevOps Engineer

> Designed and deployed end-to-end as part of a 4-week cloud engineering sprint demonstrating production-grade AWS infrastructure using Terraform and Docker.
