variable "instance_type" {
  description = "type of ec2 instance"
#   default     = "t2.micro"
}
variable "instance_name" {
  description = "name of ec2 instance"
  type = string
}

variable "worksapce_iam_roles" {
  description = "Specify role to workspace"
  default = {
    staging = "arn:aws:iam::STAGING-ACCOUNT-ID:role/terraform"
    product = "arn:aws:iam::PRODUCT-ACCOUNT-ID:role/terraform"
  }
}