terraform {
  # setup remote state servivers
  # backend "remote" {
  #   organization = "dotrunghg1999"
  #   workspaces {
  #     name = "Provisioner-Handsons"
  #   }
  # }
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
  public_key = file("./terraform.pub")
  # public_key = tls_private_key.rsa-example.public_key_openssh
}


# RSA key of size 4096 bits
# resource "tls_private_key" "rsa-example" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# # save privatekey
resource "local_file" "terraform-key" {
  # content =  tls_private_key.rsa-example.private_key_pem
  content         = "tls_private_key.rsa-example.private_key_pem"
  filename        = "./terraform-new"
  file_permission = "0400"
}


resource "aws_instance" "my_server" {
  ami           = "ami-01b32aa8589df6208"
  instance_type = "t2.micro"
  # instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  # note: use intepolation
  user_data = data.template_file.user_data.rendered
  key_name  = aws_key_pair.deployer.key_name
  tags = {
    Name = "Created by terraform"
  }


  # this exec in local 
  provisioner "local-exec" {
    command = " echo ${self.private_ip} >> private_ips.txt"
  }


  # this exec in remote ec2 
  provisioner "remote-exec" {
    inline = [
      # "echo ${self.private_ip} >> home/ec2-user/private_ips.txt"
      "mkdir testtt",
      "mkdir testtt2",
      "echo ${self.private_ip} >> private_ip.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./terraform")
      host        = self.public_ip
    }

  }

  # file
  provisioner "file" {
    source = "./test-provisioner-file.txt"
    destination = "test-upload-file.txt"
    # content = "abc"
     connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./terraform")
      host        = self.public_ip
    }

  }




}


# null resource
# learn more about usecases of null resource view here: https://jhooq.com/terraform-null-resource/
resource "null_resource" "status" {
  provisioner "local-exec" {
    command = " aws ec2 wait instance-status-ok --instance-ids ${aws_instance.my_server.id}"
  }

  depends_on = [ aws_instance.my_server ]

}



output "public_ip" {
  value = aws_instance.my_server.public_ip
}


# output "file_path" {
#   value = local_file.terraform-key.filename
# }
