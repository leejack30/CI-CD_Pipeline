resource "tls_private_key" "rsa-4096-test" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tls_key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa-4096-test.public_key_openssh
}

resource "local_file" "example" {
  # 文件路徑
  filename = var.key_name
  # 文件内容
  content  = tls_private_key.rsa-4096-test.private_key_pem
}
