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



resource "aws_instance" "ec2_server_1" {
  ami = "ami-0d52744d6551d851e" # ubuntu
  # ami           = "ami-01b32aa8589df6208" # aws linux
  instance_type = "t2.micro"
  tags = {
    Name = "Server 1"
  }
  vpc_security_group_ids = ["sg-03c408bce54600c4a"]

  lifecycle {
    # prevent_destroy = true # tránh xoá nhầm, vd xoá  terraform destroy  thì sẽ log ra thông báo lõi.  usecase thường dùng ở resource DB
    # create_before_destroy = true   # mặc định false là Xoá -> Tạo mới. Nếu là true thì tạo rồi mới xoá 
    # ignore_changes        = [tags] # bỏ qua phần thay đổi của tags
    replace_triggered_by = [  aws_instance.ec2_server_2.id , aws_instance.ec2_server_2.vpc_security_group_ids ]
  }

}

resource "aws_instance" "ec2_server_2" {
  ami = "ami-0d52744d6551d851e" # ubuntu
  # ami           = "ami-01b32aa8589df6208" # aws linux
  vpc_security_group_ids = ["sg-0f7b0cad6f96c0929"]
  instance_type = "t2.micro"
  tags = {
    Name = "Server 2 23 "
  }
}


