terraform {
  # Nơi lưu trữ state của tf. remote day la terraform cloud
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "dotrunghg1999"
    workspaces {
      name = "terraform-getting-start"
    }

  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"
    }
  }
}

locals {
  project_name = "wakudoki"
}
