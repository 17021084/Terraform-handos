# Hand ons contents

1. Connect to Terraform cloud </br>
2. Connect to aws ec2 via  key pair</br>

</br>

```bash
# gen sshkey
ssh-keygen -t rsa 
# just hand ons demo so save pub in this folder isnt problem
# -> fillname ex: terraform

chmod 400 terraform

```

</br>

3. Create user data file </br>

</br>

```terraform
 # note: use intepolation
  user_data              = "${data.template_file.user_data.rendered}"
```

4. create security group and open ssh 22 and http 80
</br>
Note: where i put public ipv4 on browser  it will be "https://ipv4" so we cant touch

```
 ssh ec2-user@$(terraform output -raw public_ip) -i terraform

passphase -> yes
```