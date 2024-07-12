///key pair creating

resource "aws_key_pair" "key-tf" {
  key_name   = "key-new"
  public_key = file("${path.module}/id_rsa.pub")
}

output "keyname" {
  value = aws_key_pair.key-tf.key_name
}

