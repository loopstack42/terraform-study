## ✅ 目標
在AWS 環境中建置VPC

## ⚙️ 操作過程

## 🧠 學到什麼

## 🪲 遇到什麼錯誤、怎麼解決
### 問題一
**情境**：執行"terrafrom apply時，resource name設定為"public subnet"
**錯誤訊息**："Invalid resource name"
**原因分析**：名稱只能用字母與底線開頭，內容可以包含字母、數字與底線，但不能包含空白
**解決方式**：調整resource name為"public_subnet"

### 問題二
**情境**：執行"terrafrom apply時，出現dependency file不一致
**錯誤訊息**："Inconsistent dependency lock file"
**原因分析**：main.tf檔案中宣告的provider版本跟.terraform.lock.hcl文件紀錄的不一致，.terraform.lock.hcl中AWS Provider 是5.98.0的版本，main.tf用的是 ~> 4.16
**解決方式**：
#### 1.更新main.tf中的provider版本約束
```Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16" # 你的错误提示显示这里是 ~> 4.16
    }
  }
}
```
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # 或者 ">= 4.16" 甚至 ">= 5.0"
    }
  }
}
```
重新初始化，terraform init -upgrade後再次執行terraform apply
