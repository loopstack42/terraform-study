terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-1"
}

resource "aws_vpc" "kevin_main" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "kevin"
  }
}

resource "aws_subnet" "public_subnet" {
    cidr_block = "192.168.1.0/24"
    vpc_id = aws_vpc.kevin_main.id
}