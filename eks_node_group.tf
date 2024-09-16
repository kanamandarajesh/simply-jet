# Define the security group for EKS worker nodes
resource "aws_security_group" "eks_worker_group" {
  vpc_id = var.vpc_id

  ingress {
    description = "Allow all traffic from the EKS control plane"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.eks.cluster_security_group_cidrs[0]] # Allow EKS control plane access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-worker-sg"
  }
}

# Define the node IAM role for EC2 instances in the managed node group
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach the EKS worker node policy to the IAM role
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach autoscaling permissions to the role
resource "aws_iam_role_policy_attachment" "eks_autoscaler_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
}
