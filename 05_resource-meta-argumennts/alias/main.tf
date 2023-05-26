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
  alias  = "tokyo"
}

provider "aws" {
  region = "ap-northeast-3"
  alias  = "osaka"
}

# data "aws_ami" "amazon-linux" {
#   most_recent = true
#   owners = [ "amazon" ]
#     filter {
#     name   = "tag:FreeTierEligible"
#     values = ["true"]
#   }

# }




resource "aws_instance" "tokyo_ec2_server" {

  # ami           = data.aws_ami.amazon-linux.id
  ami           = "ami-01b32aa8589df6208"
  instance_type = "t2.micro"
  provider      = aws.tokyo
  tags = {
    Name = "Server ec2 aws.tokyo "
  }
}
resource "aws_instance" "osaka_ec2_server" {

  ami           = "ami-0997b4797ae01c920"
  # ami           = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"
  provider      = aws.osaka
  tags = {
    Name = "Server ec2 aws.osaka"
  }
}


output "osaka_public_ip" {
  # terraform built in function
  value = aws_instance.osaka_ec2_server.public_ip
}
output "tokyo_public_ip" {
  # terraform built in function
  value = aws_instance.tokyo_ec2_server.public_ip
}
