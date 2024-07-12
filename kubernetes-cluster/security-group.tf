//creating security Groups  

resource "aws_security_group" "security_group_all" {
  name        = "security_group_all"
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

  tags = {
    "Name" = "ssecurity-group-all"
  }
}


output "sg-output" {
  value = aws_security_group.security_group_all.id
}

