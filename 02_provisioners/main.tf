terraform {
  # setup remote state servivers
  backend "remote" {
    organization = "dotrunghg1999"
    workspaces {
      name = "Provisioner-Handsons"
    }
  }
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

data "aws_vpc" "main" {
  id = "vpc-0a9d221c739b688f4"
}

data "template_file" "user_data" {
  template = file("./userdata.yaml")
}


resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My server group - Allow http req"
  vpc_id      = data.aws_vpc.main.id

  ingress = [{
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }

  ]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


# to access ec2
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDrMjhx5KM8utAm09H80TZ9qh9KqCb+8JrYYFch+avhl3SlrkaDeXtSp7WqQhslyEpo+8gbsiUfGW7bnoSbFn9+9ZdSEcogxdfJ1GA/J1xtIKwM8jDf+q4klOmhatpo8g60sURJT6qk2kEoiljnQtepCBHTs1L7y4xx68S59716tmAJPhbmfRW4MCpQDmJavZggeOpvLjTVExkq0GkhpFWjw5qY53WnWqR6rYSIKhqHaIkUy7Df2anb3ysrgbwUhpMZkuRr7eIKXDEoqUTqT1atn7TIJr4eHxQ5WritVwAVC7dXumxBz9cHDlBMOWb959GXybUxtJulOuo+KSPlHtoIeJLENeQrRHZ64GuV9spsG2Bl3sVz/Xt0iG0bm2g6yxYLN6ulsVws6uP9HmphdLb7JyRVzEuOc/ik+nqFztu4kGpgncJ19mz08y+LeabB/qZCLZtqgE5qlKhBppQCQ1i5ILuDHZ2zJedtgc60li04b8mi8QnWvThTCFuhyJVtxFU= doquangtrung@Dos-MacBook-Pro.local"
}


resource "aws_instance" "my_server" {
  ami = "ami-01b32aa8589df6208"
  #   instance_type = "t2.micro"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]


  # note: use intepolation
  user_data              = "${data.template_file.user_data.rendered}"



  tags = {
    Name = "Created by terraform"
  }
}



output "public_id" {
  value = aws_instance.my_server.public_ip
}
