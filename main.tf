terraform {
  backend "s3" {
    bucket         = "studds"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "studds"
  }
}
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.aws_region
}
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_eip" "myEIP" {
  vpc = true
}

resource "aws_nat_gateway" "NAT-GW" {
  allocation_id = aws_eip.myEIP.id
  subnet_id     = aws_subnet.mypublicsubnet.id
}

