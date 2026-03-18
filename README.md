# Azure Web Application Infrastructure Deployment with Terraform

Infrastructure-as-Code implementation for deploying and managing a cloud-hosted web application environment on **Microsoft Azure** using **Terraform**.

This project demonstrates how cloud infrastructure can be provisioned, managed, and version-controlled using Terraform while following modern **DevOps and Infrastructure-as-Code (IaC) practices**. The infrastructure is defined declaratively and deployed to Azure through automated workflows.

A key component of this implementation is the use of **remote Terraform state stored securely in an Azure Storage Account**, enabling safe state management and collaborative infrastructure workflows.

---

# Project Overview

Cloud infrastructure traditionally configured through web portals can lead to configuration inconsistencies and difficult-to-track changes. Terraform enables teams to define infrastructure in code, ensuring environments are consistent, reproducible, and version controlled.

This project provisions Azure infrastructure required to host a web application using Terraform configuration files. Infrastructure resources are deployed through Azure Resource Manager and tracked using a remote Terraform state backend hosted in Azure.

The repository also includes a **GitHub Actions workflow**, enabling infrastructure deployment and validation as part of a CI/CD pipeline.

---

# Solution Architecture

The infrastructure architecture follows a typical Azure deployment pattern for hosting web applications using Platform-as-a-Service resources.
Developer
│
│ Terraform CLI / GitHub Actions
▼
Terraform Configuration
│
▼
Azure Resource Manager
│
├── Resource Group
│
├── Azure App Service Plan
│
├── Azure Web App
│
└── Azure Storage Account
│
└── Terraform Remote State

Using this architecture ensures infrastructure deployments are **automated, traceable, and secure**.

---

# Technologies Used

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure provisioning |
| Microsoft Azure | Cloud platform |
| Azure App Service | Web application hosting |
| Azure Storage Account | Remote Terraform state storage |
| GitHub Actions | CI/CD automation |
| HCL (HashiCorp Configuration Language) | Infrastructure configuration language |

---

# Remote Terraform State Management

This project uses **Azure Storage Account as a remote backend** for Terraform state management.

Remote state storage is a recommended best practice because it allows infrastructure state to be:

- stored securely
- shared across team members
- protected from local machine failures
- locked during deployments to prevent conflicts

The Terraform state is stored in:
Azure Storage Account
└── Blob Container
└── terraform.tfstate

This ensures that infrastructure state remains centralized and protected.

---

# Repository Structure
├── .github
│ └── workflows
│ └── terraform-deployment.yml
│
├── main.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── terraform.tfstate.backup
└── .gitignore

---

# Terraform Configuration Files

## provider.tf

Defines the Azure provider configuration and connects Terraform to the Azure environment.

Typical configuration includes:

- Azure subscription authentication
- provider version configuration
- remote backend configuration for Azure Storage

---

## main.tf

The primary infrastructure definition file.

This file contains the resources required to provision Azure infrastructure components including:

- resource groups
- app service plans
- web application resources

Terraform processes these resource blocks to deploy the infrastructure environment.

---

## variables.tf

Defines reusable input variables used throughout the Terraform configuration.

This allows infrastructure parameters to be customized without modifying the core infrastructure code.

Examples include:

- resource group name
- application name
- region
- service plan configuration

---

## terraform.tfvars

Stores the values assigned to the variables defined in `variables.tf`.

Separating configuration values from infrastructure definitions improves maintainability and enables multiple environment configurations.

Example configuration:
location = "Canada Central"
app_service_name = "groupa-webapp"

---

## outputs.tf

Defines output variables that are displayed after Terraform deployment.

Outputs typically expose useful information such as:

- application URL
- service endpoints
- resource identifiers

These outputs can be used by other automation pipelines or tools.

---

# CI/CD Automation

The repository includes **GitHub Actions workflows** that support automated infrastructure deployment.

The workflow performs tasks such as:

- Terraform initialization
- configuration validation
- infrastructure planning
- deployment to Azure

This enables infrastructure updates to be managed through **version-controlled pipelines** rather than manual configuration.

---

# Deployment Workflow

The infrastructure can be deployed locally using Terraform or through the CI/CD pipeline.

### Initialize Terraform

```bash
terraform init

### Validate Configuration
terraform validate

Generate Infrastructure Plan
terraform plan

Deploy Infrastructure
terraform apply

Terraform will then provision the defined Azure resources and update the remote state file in the Azure Storage Account.

Key Capabilities Demonstrated
Infrastructure as Code

**Terraform-based infrastructure provisioning**

declarative resource configuration

version-controlled infrastructure

**Cloud Platform Management**

Azure resource provisioning

PaaS application hosting configuration

infrastructure lifecycle management

**DevOps Practices**

CI/CD automation using GitHub Actions

remote Terraform state management

reproducible cloud deployments

**Skills Demonstrated**

Terraform Infrastructure-as-Code

Microsoft Azure Cloud Infrastructure

Azure App Service Deployment

Azure Storage Remote State Management

CI/CD Automation with GitHub Actions

Infrastructure Version Control
