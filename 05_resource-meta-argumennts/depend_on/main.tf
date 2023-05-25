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

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "bucket-terraform-created-by-trung"
  tags = {
    Name = "bucket created by terraform"
  }
  depends_on = [aws_instance.ec2_server]

}


resource "aws_instance" "ec2_server" {
  ami           = "ami-01b32aa8589df6208"
  instance_type = "t2.micro"
  tags = {
    name = "Server ec2"
  }

}
