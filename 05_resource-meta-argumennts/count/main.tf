terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}



resource "aws_instance" "ec2_server" {
  count         = 2
  ami           = "ami-01b32aa8589df6208"
  instance_type = "t2.micro"
  tags = {
    Name = "Server ec2 ${count.index}"
  }
}

output "public_ip" {
  value = aws_instance.ec2_server[*].public_ip
}
