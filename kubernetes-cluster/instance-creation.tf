//// fot selecting ubuntu ami

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


// instance creating 

resource "aws_instance" "server1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = ["${aws_security_group.security_group_all.id}"]
  user_data              = file("kubernetes-install.sh")

  tags = {
    Name = "server1"
  }
}

output "script-print" {
 # value = file("${path.module}/kubernetes-install.sh")
  value = aws_instance.server1.user_data
}

