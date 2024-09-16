provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)
  
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets_cidr[count.index]
  map_public_ip_on_launch = true
  
  availability_zone = element(var.availability_zones, count.index)
  
  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)
  
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets_cidr[count.index]
  
  availability_zone = element(var.availability_zones, count.index)
  
  tags = {
    Name = "private-subnet-${count.index}"
  }
}
