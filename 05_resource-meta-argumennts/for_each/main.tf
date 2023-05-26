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
  # create mutil instances of a resource.  each value inside for_each
  for_each = {
    config_1 = {
      type = "t2.micro"
      ami  = "ami-01b32aa8589df6208"
    },
    config_2 = {
      type = "t2.micro"
      ami  = "ami-07c2a88388bb80eb0"
    }

  }
  ami           = each.value.ami
  instance_type = each.value.type

  tags = {
    Name = "Server ec2  ${each.key}"
  }
}

output "public_ip" {
  # terraform built in function
  value = values(aws_instance.ec2_server)[*].public_ip
}
