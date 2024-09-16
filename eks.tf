# Using the official AWS EKS module for EKS cluster provisioning
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.14.0"  # Specify the version you want
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.private_subnets
  vpc_id          = var.vpc_id

  # Enable control plane logging for better monitoring and debugging
  enable_control_plane_log = true

  # IAM roles for the EKS cluster
  cluster_iam_role_name = aws_iam_role.eks_cluster_role.name

  # Managed node group settings
  node_groups = {
    eks_managed_node_group = {
      desired_capacity = var.desired_capacity
      max_capacity     = var.max_capacity
      min_capacity     = var.min_capacity

      instance_type = var.instance_type
      key_name      = var.key_name

      additional_security_group_ids = [aws_security_group.eks_worker_group.id]

      tags = {
        Name = "eks-node-group"
      }
    }
  }

  tags = {
    Environment = "production"
    Project     = "migration"
  }
}
