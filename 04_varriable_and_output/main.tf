terraform {

}


module "aws_server" {
  source        = "./aws_server"
  instance_type = "t2.micro"
}


output "public_ip" {
  value = module.aws_server.ec2_public_ip // output of module
  # sensitive = true
}


output "instance_type" {
  value = module.aws_server.ec2_instance_type
}