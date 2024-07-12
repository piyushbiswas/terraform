# VPC for us-east-1
resource "aws_vpc" "vpc_us_east_1" {
  provider    = aws.us_east_1
  cidr_block  = "10.0.0.0/16"
  tags = {
    Name = "vpc-us-east-1"
  }
}


resource "aws_subnet" "subnet_us_east_1" {
  provider            = aws.us_east_1
  vpc_id              = aws_vpc.vpc_us_east_1.id
  cidr_block          = "10.0.1.0/24"
  availability_zone   = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "subnet-us-east-1"
  }
}


resource "aws_route_table" "rt_us_east_1" {
  provider = aws.us_east_1
  vpc_id   = aws_vpc.vpc_us_east_1.id
  tags = {
    Name = "rt-us-east-1"
  }
}


resource "aws_route_table_association" "rta_us_east_1" {
  provider        = aws.us_east_1
  subnet_id       = aws_subnet.subnet_us_east_1.id
  route_table_id  = aws_route_table.rt_us_east_1.id
}

resource "aws_instance" "instance_us_east_1" {
  provider      = aws.us_east_1
  ami           = "ami-04b70fa74e45c3917"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_us_east_1.id
  tags = {
    Name = "instance-us-east-1"
  }
}

# VPC for us-east-2
resource "aws_vpc" "vpc_us_east_2" {
  provider    = aws.us_east_2
  cidr_block  = "10.1.0.0/16"
  tags = {
    Name = "vpc-us-east-2"
  }
}

resource "aws_subnet" "subnet_us_east_2" {
  provider            = aws.us_east_2
  vpc_id              = aws_vpc.vpc_us_east_2.id
  cidr_block          = "10.1.1.0/24"
  availability_zone   = "us-east-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "subnet-us-east-2"
  }
}


resource "aws_route_table" "rt_us_east_2" {
  provider = aws.us_east_2
  vpc_id   = aws_vpc.vpc_us_east_2.id
  tags = {
    Name = "rt-us-east-2"
  }
}

resource "aws_route_table_association" "rta_us_east_2" {
  provider        = aws.us_east_2
  subnet_id       = aws_subnet.subnet_us_east_2.id
  route_table_id  = aws_route_table.rt_us_east_2.id
}

resource "aws_instance" "instance_us_east_2" {
  provider      = aws.us_east_2
  ami           = "ami-09040d770ffe2224f"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_us_east_2.id
  tags = {
    Name = "instance-us-east-2"
  }
}


