# IAM policy for Cluster Autoscaler
resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name = "cluster-autoscaler-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "autoscaling:UpdateAutoScalingGroup",
          "ec2:Describe*"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the node IAM role for autoscaler to control EC2 Auto Scaling
resource "aws_iam_role_policy_attachment" "cluster_autoscaler_policy_attachment" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = aws_iam_policy.cluster_autoscaler_policy.arn
}

# Deploy Cluster Autoscaler using Helm (as a Kubernetes resource)
resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  chart      = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  namespace  = "kube-system"

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "extraArgs.scale-down-unneeded-time"
    value = "10m"
  }

  set {
    name  = "extraArgs.scale-down-delay-after-add"
    value = "5m"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks.amazonaws.com/role-arn"
    value = aws_iam_role.eks_node_role.arn
  }
}
