terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"
    }
  }
}

provider "aws" {
  # Configuration options
    profile = "trungadmin"
  region = "ap-northeast-1"
}

variable "instance_type" {
  description = "type of ec2 instance"
  type= string
  default = "t2.micro"
}


locals {
  project_name = "wakudoki"
}



resource "aws_instance" "created_by_terraform" {
  ami           = "ami-01b32aa8589df6208"
#   instance_type = "t2.micro"
  instance_type = var.instance_type

  tags = {
    Name = "this is -${local.project_name} project and created_by_terraform."
  }
}


output "instance_ip_address" {
  value = aws_instance.created_by_terraform.public_ip
}