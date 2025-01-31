
// security group creating

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"


  dynamic "ingress" {
    for_each = var.ports_to_be_open
    iterator = port
    content {
      description = "PORTS OPENING"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ////lengthy code

  # ingress {
  #   description      = "HTTPS"
  #   from_port        = 443
  #   to_port          = 443
  #   protocol         = "tcp"
  #   cidr_blocks      = "0.0.0.0/0"
  # }

  # ingress {
  #   description      = "HTTP"
  #   from_port        = 80
  #   to_port          = 80
  #   protocol         = "tcp"
  #   cidr_blocks      = "0.0.0.0/0"
  # }

  # ingress {
  #   description      = "SSH"
  #   from_port        = 22
  #   to_port          = 22
  #   protocol         = "tcp"
  #   cidr_blocks      = "0.0.0.0/0"
  # }
  # egress {
  #   from_port        = 0
  #   to_port          = 0
  #   protocol         = "-1"
  #   cidr_blocks      = ["0.0.0.0/0"]
  #   ipv6_cidr_blocks = ["::/0"]
  # }

  # tags = {
  #   Name = "allow_tls"
  # }
}

output "sg-output" {
  value = aws_security_group.allow_tls.id
}