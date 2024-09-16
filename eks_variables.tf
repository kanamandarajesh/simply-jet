variable "cluster_name" {
  description = "EKS cluster name"
  default     = "my-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for EKS"
  default     = "1.21"
}

variable "vpc_id" {
  description = "VPC ID for EKS cluster"
}

variable "private_subnets" {
  description = "Private subnets for EKS worker nodes"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type for EKS worker nodes"
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Desired capacity for EKS managed node group"
  default     = 3
}

variable "min_capacity" {
  description = "Minimum capacity for EKS managed node group"
  default     = 1
}

variable "max_capacity" {
  description = "Maximum capacity for EKS managed node group"
  default     = 5
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  default     = "my-keypair"
}

variable "aws_region" {
  description = "AWS region for EKS deployment"
  default     = "us-west-2"
}
