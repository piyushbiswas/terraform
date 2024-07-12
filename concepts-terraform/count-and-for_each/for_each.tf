resource "aws_instance" "example1" {
  for_each = {
    instance1 = "ami-123456"
    instance2 = "ami-654321"
  }

  ami           = each.value
  instance_type = "t2.micro"

  tags = {
    Name = each.key
  }
}
