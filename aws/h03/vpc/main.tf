provider "aws" {
  region = "ap-northeast-2"
}

### VPC Start ###

resource "aws_vpc" "kogoon-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = "KOGOON-VPC"
  }
}

resource "aws_internet_gateway" "kogoon-igw" {
  vpc_id = aws_vpc.kogoon-vpc.id

  tags = {
    Name = "KOGOON_IGW"    
  }
}

# Subnet Modules?
# Multi-AZ
# Public Subnet
resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.kogoon-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Kogoon-Public-a"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id = aws_vpc.kogoon-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "Kogoon-Public-c"
  }
}

# Private Subnet

resource "aws_subnet" "private_subnet_a" {
  vpc_id = aws_vpc.kogoon-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Kogoon-Private-a"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id = aws_vpc.kogoon-vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "Kogoon-Private-c"
  }
}

# DB Subnet

resource "aws_subnet" "db_subnet_a" {
  vpc_id = aws_vpc.kogoon-vpc.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Kogoon-DB-a"
  }
}

resource "aws_subnet" "db_subnet_c" {
  vpc_id = aws_vpc.kogoon-vpc.id
  cidr_block = "10.0.21.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "Kogoon-DB-c"
  }
}

# Elastic IP
resource "aws_eip" "nat_ip" {
  depends_on = [
    aws_route_table.kogoon_public_rt
  ]

  vpc        = true
}

# NAT GATEWAY
resource "aws_nat_gateway" "kogoon_nat_gw" {
  depends_on = [
    aws_eip.nat_ip
  ]

  allocation_id = aws_eip.nat_ip.id

  subnet_id = aws_subnet.public_subnet_a.id

  tags = {
    Name = "Kogoon-nat"
  }
}

# Routing Table
resource "aws_route_table" "kogoon_public_rt" {
  vpc_id = aws_vpc.kogoon-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kogoon-igw.id
  }

  tags = {
    Name = "KOGOON-PUBLIC-RT"
  }
}

resource "aws_route_table" "kogoon_private_rt" {
  depends_on = [
    aws_nat_gateway.kogoon_nat_gw
  ]

  vpc_id = aws_vpc.kogoon-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.kogoon_nat_gw.id
  }

  tags = {
    Name = "KOGOON-PRIVATE-RT"
  }
}

resource "aws_route_table_association" "kogoon_public_subnet_a_association" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.kogoon_public_rt.id
}

resource "aws_route_table_association" "kogoon_public_subnet_c_association" {
  subnet_id = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.kogoon_public_rt.id
}

resource "aws_route_table_association" "kogoon_private_subnet_a_association" {
  subnet_id = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.kogoon_private_rt.id
}

resource "aws_route_table_association" "kogoon_private_subnet_c_association" {
  subnet_id = aws_subnet.private_subnet_c.id 
  route_table_id = aws_route_table.kogoon_private_rt.id
}

### VPC END  ### 
