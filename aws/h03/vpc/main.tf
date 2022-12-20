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
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Kogoon-Private-a"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id = aws_vpc.kogoon-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "Kogoon-Private-c"
  }
}

# DB Subnet
resource "aws_subnet" "db_subnet_a" {
  vpc_id = aws_vpc.kogoon-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Kogoon-DB-a"
  }
}

resource "aws_subnet" "db_subnet_c" {
  vpc_id = aws_vpc.kogoon-vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "Kogoon-DB-c"
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
  vpc_id = aws_vpc.kogoon-vpc.id

  route = []

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
