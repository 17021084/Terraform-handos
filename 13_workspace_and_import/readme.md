# Workspace and import
## Workspace

Dùng trong trường hợp chia môi trường ra để thực thi. Mỗi một workspace là 1 môi trường và có state riêng được lưu trong ```terraform.tfstate.d ```

![](./Screen%20Shot%202023-06-20%20at%2022.25.48.png)


## import

Khi mà trên remote infra đã tạo resource rồi, muốn update state tf ở local .

Cần phải tạo file config

sau đó chạy lện

```bash
terraform import resource_type.resource_name  id
```
![](./Screen%20Shot%202023-06-20%20at%2022.24.59.png)