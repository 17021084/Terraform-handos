# Backend
link : https://developer.hashicorp.com/terraform/language/settings/backends/s3

Backend có 2 loại

* Standard backend

-> chỉ là nơi lưu trữ state của tf


* Enhance backend

-> Là nơi lưu trữ state
-> thự thi các operations của terraform ( apply , init , plan ,...)



-----

# Terraform workspace


```bash

# List cac options 
terraform workspace 


# khi apply file tuyf theo moi truong thi se nhu nay
terraform apply -var-file staging.tfvars

```

