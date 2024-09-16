# Here are the Terraform configurations to create the VPC and Networking components.
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

