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
  
  ami           = "ami-0f9816f78187c68fb"
  instance_type = "t2.micro"
#   tags = {
#     Name = "Server ec2 test"
#   }
}
