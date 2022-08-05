provider "aws" {
  region = "ap-northeast-2"
}

### VPC START ###

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = "MY-VPC"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "my_public_subnet_a" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  
  tags = {
    Name = "MY-PUBLIC-SUBNET-A"
  }
}

resource "aws_subnet" "my_public_subnet_c" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "MY-PUBLIC-SUBNET-C"
  }
}

resource "aws_subnet" "my_private_subnet_a" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "MY-PRIVATE-SUBNET-A"
  }
}

resource "aws_subnet" "my_private_subnet_c" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.1.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "MY-PRIVATE-SUBNET-C"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  
  tags = {
    Name = "MY-IGW"
  }
}

resource "aws_route_table" "my_public_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  
  tags = {
    Name = "MY-PUBLIC-RTB"
  }
}

resource "aws_route_table" "my_private_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route = []
  
  tags = {
    Name = "MY-PRIVATE-RTB"
  }
}


resource "aws_route_table_association" "my_public_subnet_a_association" {
  subnet_id = aws_subnet.my_public_subnet_a.id
  route_table_id = aws_route_table.my_public_rtb.id
}

resource "aws_route_table_association" "my_public_subnet_c_association" {
  subnet_id = aws_subnet.my_public_subnet_c.id
  route_table_id = aws_route_table.my_public_rtb.id
}

resource "aws_route_table_association" "my_private_subnet_a_association" {
  subnet_id = aws_subnet.my_private_subnet_a.id
  route_table_id = aws_route_table.my_private_rtb.id
}

resource "aws_route_table_association" "my_private_subnet_c_association" {
  subnet_id = aws_subnet.my_private_subnet_c.id
  route_table_id = aws_route_table.my_private_rtb.id
}


### VPC END ###
