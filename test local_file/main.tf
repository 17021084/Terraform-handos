resource "local_file" "name" {
  content  = " tls_private_key.rsa-example.private_key_pem"
  filename = "./abc.txt"
   provisioner "local-exec" {
    command = "chmod 400 abc.txt"
  }
}
resource "local_sensitive_file" "foo" {
  content  = "foo!"
  filename = "${path.module}/foo"
  file_permission = "0400"
}
# file_permission = "0400"
  #  provisioner "local-exec" {
  #   command = "chmod 400 terraform"
  # }