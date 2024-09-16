resource "aws_ebs_volume" "postgres_data" {
  availability_zone = "us-west-2a"  # Replace with your desired AZ
  size              = 100           # Size in GB
  type              = "gp3"         # General purpose SSD
  encrypted         = true
  kms_key_id        = aws_kms_key.ebs_key.arn
  tags = {
    Name = "postgres-data-volume"
  }
}

resource "aws_ebs_volume" "redis_data" {
  availability_zone = "us-west-2a"
  size              = 50
  type              = "gp3"
  encrypted         = true
  kms_key_id        = aws_kms_key.ebs_key.arn
  tags = {
    Name = "redis-data-volume"
  }
}
