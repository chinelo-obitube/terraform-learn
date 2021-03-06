provider "aws" {
  region     = "eu-west-2"
}

variable "subnet_cidr_block" {
  description =   "subnet_cidr_block"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
      Name: "development"
      vpc_env: "dev"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id     = aws_vpc.development-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "eu-west-2a"
}

data "aws_vpc" "existing_vpc" {
    default = true
}


resource "aws_subnet" "dev-subnet-2" {
  vpc_id     = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "eu-west-2a"
} 

output "dev-vpc-id"{
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id"{
  value = aws_subnet.dev-subnet-1.id
}