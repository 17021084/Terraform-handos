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
  #   profile = "trungadmin"
  region = "ap-northeast-1"
}


resource "aws_instance" "created_by_terraform" {
  ami           = "ami-01b32aa8589df6208"
  instance_type = "t2.micro"
  
}

