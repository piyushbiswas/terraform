resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "my_internet_gw" {
  vpc_id = aws_vpc.myvpc.id

}

resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.my_internet_gw.id
  }
}

resource "aws_route_table_association" "my_rt1_dont_know" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my_rt.id
}

resource "aws_security_group" "my_sg" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

resource "aws_s3_bucket" "my_s3_bucket_project" {
  bucket = "my_s3_bucket_project_1"

}

resource "aws_instance" "webserver1" {
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    subnet_id = aws_subnet.public_subnet.id
    user_data = base64decode(file("user-data.sh"))
}

resource "aws_instance" "webserver2" {
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    subnet_id = aws_subnet.private_subnet.id
    user_data = base64decode(file("user-data1.sh"))
}
