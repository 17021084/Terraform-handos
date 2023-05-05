
output "instance_ip_address" {
  value = aws_instance.created_by_terraform.public_ip
}
