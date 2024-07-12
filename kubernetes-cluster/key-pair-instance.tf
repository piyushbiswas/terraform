

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048

}


resource "local_sensitive_file" "private_key_file" {
  content  = tls_private_key.private_key.private_key_pem
  filename = "${path.module}/id_rsa"
}




resource "local_sensitive_file" "public_key_file" {
  content  = tls_private_key.private_key.public_key_openssh
  filename = "${path.module}/id_rsa.pub"
}


output "public_key" {
  value = tls_private_key.private_key.public_key_openssh
  #   sensitive = true
}

output "private_key" {
  value     = tls_private_key.private_key.private_key_pem
  sensitive = true
}

resource "aws_key_pair" "deployer" {
  key_name   = "server-key"
  public_key = tls_private_key.private_key.public_key_openssh

}

