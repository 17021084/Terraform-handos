# Refesh


### Replace resource (taint)

Thay force thế resource  được chỉ định 


```bash
terrafrom apply -replace=<resource address>

terrafrom apply -replace=aws_resource.ec2_server

# tự động replace resource. ( xoá đi và tạo lại )
```

![](./Screen%20Shot%202023-06-03%20at%2016.14.14.png)
![](Screen%20Shot%202023-06-03%20at%2016.18.12.png)


### Refresh-only

Nếu remote resource có sự thay đổi gì đó.
thì refresh-only sẽ cập nhập state ở local để giống sự thay đổi đó <br>


ví dụ

b1 tạo EC2 bằng terraform <br/>


b2 Trên console, thực hiện xoá ec2.  MỤC ĐÍCH  TEAM LÀ XOÁ <br/>

b3 chạy lai apply.  Đợi 1 lúc để remote resource update state<br/>

![](./Screen%20Shot%202023-06-03%20at%2016.33.03.png)

Khi mình apply thì, tf sẽ pull state ở remote và so sánh state ở local-> add thêm resource mới  <br/>

ec2 sẽ đc tạo lại -> mục đich xoá ở step 2 sẽ ko thực hiện được -> conflict. <br>

Giải phái: Chạy refresh only

```bash

terraform apply -refresh-only
```

-> pull state  từ remote về  và sửa state ở local theo state từ remote . Ko tạo bất cứ resource nào trên remote 
![](Screen%20Shot%202023-06-03%20at%2016.37.11.png)
![](./Screen%20Shot%202023-06-03%20at%2016.37.20.png)




> This is a refresh-only plan, so Terraform will not take any actions to undo these. If you were expecting these changes then you can apply this plan to record the
updated values in the Terraform state without changing any remote objects.

<br>sau khi apply -> locastate đã được udate lại




