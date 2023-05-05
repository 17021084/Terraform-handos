terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"
    }
  }
}




resource "aws_instance" "created_by_terraform" {
  ami = "ami-01b32aa8589df6208"
  #   instance_type = "t2.micro"
  instance_type = var.instance_type

  tags = {
    Name = "this is -${local.project_name} project and created_by_terraform."
  }
}


# lấy từ đây  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#example-usage
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  providers = {
    aws = aws.osaka
  }
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-3a", "ap-northeast-3b", "ap-northeast-3c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}




