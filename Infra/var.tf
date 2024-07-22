#建立var的目的是方便在不同專案使用相同架構下,修改var可以快速修改數值等等

variable "key_name" {
  default = "tls_key"
  description = "tls"
}

