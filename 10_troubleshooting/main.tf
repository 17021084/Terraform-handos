terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"
}


resource "aws_instance" "ec2_server" {

  ami           = "ami-01b32aa8589df6208"
  instance_type = "t2.micro"
  tags = {
    Name = "Server ec2 "
  }
}



