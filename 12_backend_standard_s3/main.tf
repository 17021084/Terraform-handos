terraform {
  backend "s3" {
    bucket = "terraform-backend-trungdq"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
    encrypt = true
  }
}

provider "aws" {
#    có thể dùng role theo từng môi trường 
#   assume_role = "${var.workspace_iam_roles[terraform.workspace]}"
}



module "apache" {
  source        = "./aws_module_apache_example"
  instance_type = var.instance_type
  instance_name = var.instance_name
}
