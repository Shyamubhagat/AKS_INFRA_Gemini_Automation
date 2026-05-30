# Azure Infrastructure with Gemini Automation

This repository contains modular Terraform code to deploy Azure Resource Groups, Container Registries (ACR), and Kubernetes Clusters (AKS) using advanced Terraform patterns.

## Features
- **Modular Design:** Highly reusable modules for RG, ACR, and AKS.
- **Advanced Terraform:** Uses `dynamic` blocks, `optional` attributes, and `for_each` with complex maps.
- **CI/CD Pipeline:** Fully automated deployment via GitHub Actions.
- **Security First:** Includes automated linting, security scanning (Tfsec), and vulnerability scanning (Checkov).

## CI/CD Workflow
The pipeline (`.github/workflows/deploy.yml`) consists of three stages:
1. **Lint & Security Scan:** Runs `terraform fmt`, `TFLint`, `Tfsec`, and `Checkov`.
2. **Terraform Plan:** Generates an execution plan and validates Azure connectivity.
3. **Terraform Apply:** Deploys the infrastructure to Azure (only on pushes to `main`).

## Prerequisites
To enable the deployment, you must add the following **GitHub Secrets** to your repository:
- `AZURE_CLIENT_ID`: The Client ID of your Azure Service Principal.
- `AZURE_TENANT_ID`: The Tenant ID of your Azure AD.
- `AZURE_SUBSCRIPTION_ID`: Your Azure Subscription ID.

## Getting Started
1. Clone the repository.
2. Update `terraform.tfvars` with your desired resource names and configurations.
3. Push to `main` to trigger the automated deployment.
