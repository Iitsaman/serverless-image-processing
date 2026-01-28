
# AWS Lambda Image Resizer (Terraform + Python)

This project provisions an **AWS Lambda function** that resizes images uploaded to an **S3 bucket**. It uses **Terraform** for infrastructure as code and **Python** for the Lambda runtime. A custom Lambda layer is built to include the [Pillow](https://python-pillow.org/) library for image processing.


--- ## 🚀 Features 

- **S3 bucket** for image uploads 
- **Lambda function** triggered on S3 events 
- **Image resizing** using Pillow 
- **Terraform-managed infrastructure**
- **CI/CD pipeline** with GitHub Actions 
- **Build scripts** for Lambda layer and deployment




---

## 🛠 Prerequisites
- AWS account with proper IAM permissions
- Terraform
- AWS CLI
- Docker
- Python 3.12 