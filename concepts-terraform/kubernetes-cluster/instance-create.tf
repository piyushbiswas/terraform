
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

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]

  tags = {
    Name = "first-terraform"
  }

  provisioner "file" {
    source      = "test.txt"
    destination = "/tmp/test.txt"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/id_rsa")
      host        = "${self.public_ip}"
    }
  }

  //user data script in aws
  user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt-get install nginx -y
sudo echo "Hi piyush" > /var/www/html/index.nginx-debian.html

  EOF
}