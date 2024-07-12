//aws vpc creation 

resource "aws_vpc" "main-tf-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-tf-vpc-1"
  }

}





// creating internet gateway for vpc

resource "aws_internet_gateway" "my-tf-igw" {
  vpc_id = aws_vpc.main-tf-vpc.id
  
  tags = {
    Name = "my-tf-igw"
  }
}



// Elastic ip for Nat gateway

resource "aws_eip" "mt_tf_eip_nat" {
  
  domain   = "vpc"
  depends_on = [ aws_internet_gateway.my-tf-igw ]
}




// creating aws natgatey

resource "aws_nat_gateway" "my_tf_nat_gw" {
  allocation_id = aws_eip.mt_tf_eip_nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "my-tf-nat-gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my-tf-igw]
}





//subnet creating public and private

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main-tf-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true  // this will assign public ip to this public subnet

  tags = {
    Name = "public-subnet"
  }
}


resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main-tf-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet"
  }
}

// routing table for public subnet


resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.main-tf-vpc.id

  tags = {
    Name = "route-table-public-subnet"
  }
}


// routing table for private subnet

resource "aws_route_table" "route_table_private" {
    vpc_id = aws_vpc.main-tf-vpc.id

    tags = {
      Name =  "route-table-private-subnet"
    }
  
}

//this is for adding routing table entry in route table of internet gw

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.route_table_public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.my-tf-igw.id}"
}


// adding entry of route in nat gateway routing table

resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.route_table_private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.my_tf_nat_gw.id}"

}




/* Route table associations */

resource "aws_route_table_association" "public" {

  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.route_table_public.id}"
}

resource "aws_route_table_association" "private" {

  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.route_table_private.id}"
}




//creating security Groups for vpc 

resource "aws_security_group" "my_tf_sg" {
  name        = "my-tf-security-group"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.main-tf-vpc.id
  


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
    "Name" = "my-tf-sg"
  }
}


output "sg-output" {
  value = aws_security_group.my_tf_sg.id
}



// create a instance in public subnet 

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

resource "aws_instance" "my-public-tf-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  availability_zone = "us-east-1a"
  key_name = "master"
  security_groups = [ aws_security_group.my_tf_sg.id ]

  tags = {
    Name = "my-public-tf-server"
  }
}


resource "aws_instance" "my-private-tf-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  availability_zone = "us-east-1b"
  key_name = "master"
  security_groups = [ aws_security_group.my_tf_sg.id ]

  tags = {
    Name = "my-private-tf-server"
  }
}
