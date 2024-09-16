# Create a KMS key for EBS and S3 encryption
resource "aws_kms_key" "ebs_s3_key" {
  description = "KMS key for encrypting EBS volumes and S3 buckets"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "Enable IAM User Permissions",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action    = "kms:*",
        Resource  = "*"
      },
      {
        Sid    = "Allow access for EBS and S3",
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = "*",
        Principal = {
          Service = [
            "ec2.amazonaws.com",
            "s3.amazonaws.com"
          ]
        }
      }
    ]
  })
  
  key_usage                 = "ENCRYPT_DECRYPT"
  customer_master_key_spec  = "SYMMETRIC_DEFAULT"
}

# Alias for easier identification
resource "aws_kms_alias" "alias" {
  name          = "alias/ebs-s3-key"
  target_key_id = aws_kms_key.ebs_s3_key.key_id
}
# below is for EBS
resource "aws_ebs_volume" "db_volume" {
  availability_zone = var.availability_zone
  size              = 100
  encrypted         = true
  kms_key_id        = aws_kms_key.ebs_s3_key.arn
  
  tags = {
    Name = "db-volume"
  }
}
# below is for s3
resource "aws_s3_bucket" "backup_bucket" {
  bucket = var.s3_bucket_name
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.ebs_s3_key.arn
      }
    }
  }
  
  tags = {
    Name = "backup-bucket"
  }
}


