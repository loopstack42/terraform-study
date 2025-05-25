terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-1"
}

# vpc
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "terraform_vpc"
  }
}

#subnet
resource "aws_subnet" "public_subnet_1" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.terraform_vpc.id
}

resource "aws_subnet" "public_subnet_2" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.terraform_vpc.id
}

resource "aws_subnet" "private_subnet_1" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.terraform_vpc.id
}

resource "aws_subnet" "private_subnet_2" {
    cidr_block = "10.0.3.0/24"
    vpc_id = aws_vpc.terraform_vpc.id
}


# IGW
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.terraform_vpc.id

}

#EIP
resource "aws_eip" "nat_eip" {
  domain   = "vpc"
  tags  = {
    Name =  "nat-eip"
  }
}

# NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat-gw"
  }
  depends_on = [aws_internet_gateway.igw]
}