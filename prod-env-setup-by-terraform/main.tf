resource "aws_vpc" "prod_ready_env_terraform" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"


  tags = {
    Name = "vpc_prod_ready_env"
  }
}

resource "aws_subnet" "public_subnets_prod_env" {  
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.prod_ready_env_terraform.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets_prod_env" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.prod_ready_env_terraform.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zone, count.index)

tags = {
  Name = "Private Subnet ${count.index +1}"
}

}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.prod_ready_env_terraform.id

    tags = {
      Name = "igw-prod-env"
    }
  
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.prod_ready_env_terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route_table_prod_env_gor_igw"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
count = length(var.public_subnet_cidrs)
subnet_id = element(aws_subnet.public_subnets_prod_env[*].id, count.index)
route_table_id = aws_route_table.route_table.id
}


resource "aws_eip" "ip" {
  domain = "vpc"
  tags = {
    Name = "elasticIP"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.ip.id
  count = length(var.public_subnet_cidrs)
  subnet_id = element(aws_subnet.public_subnets_prod_env[*].id, count.index)
#   subnet_id     = aws_subnet.public_subnets_prod_env.id

  tags = {
    Name = "gw-NAT"
  }
}

resource "aws_route_table" "nat_route_table" {
  vpc_id = "${aws_vpc.prod_ready_env_terraform.id}"
  


  route {
    cidr_block = "0.0.0.0/0"
    count = length(var.nat_gw)
    gateway_id = aws_nat_gateway.nat_gw.id

  }

  tags = {
    Name = "nat_route_table"
  }
}

 resource "aws_route_table_association" "asso_nat-gaw_to_private_subnet" {
  subnet_id      = aws_subnet.public_subnets_prod_env[count.index]
  route_table_id = aws_route_table.nat_route_table.id
}


