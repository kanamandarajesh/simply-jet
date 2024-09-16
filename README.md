# A.Here are the Terraform configurations to create the VPC and Networking components.
## 1.VPC Module

The vpc.tf will define the VPC, including public and private subnets across multiple Availability Zones.which included with variables.tf we have configured.

## 2. Internet Gateway

internet_gateway.tf – Create Internet Gateway and associate it with the VPC

## 3. NAT Gateway

nat_gateway.tf – Create NAT Gateways for private subnets to access the internet

## 4. Route Tables
route_tables.tf – Define Route Tables for public and private subnets

## 5. Security Groups

security_groups.tf – Define Security Groups

## 6. Route 53 Integration
route_53.tf – Set up Route 53 for DNS Management
###  Variables (route53_variables.tf) for Route 53


# B.Here are the Terraform configurations for defining IAM roles for EKS and S3 access, as well as enabling KMS for encryption of data at rest in S3 and EBS.

## 1. IAM Roles for EKS and S3
The IAM roles will provide necessary permissions for the EKS cluster and pods to access AWS services like S3.
iam_roles.tf – Define IAM Roles for EKS and S3

## Variables for IAM Roles (iam_variables.tf)

# 2. KMS Configuration
The KMS (Key Management Service) setup will provide encryption for data at rest in S3 and EBS volumes.
## kms.tf – Define KMS for S3 and EBS Encryption
Usage of KMS Key for EBS and S3 Encryption
In our EBS volume or S3 configuration, mentioned in that .tf file for reference.



