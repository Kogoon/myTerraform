### VPC Start ###

resource "aws_vpc" "mebbly-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = "mebbly-VPC"
  }
}

resource "aws_internet_gateway" "mebbly-igw" {
  vpc_id = aws_vpc.mebbly-vpc.id

  tags = {
    Name = "mebbly_IGW"    
  }
}

# Subnet Modules?
# Multi-AZ
# Public Subnet
resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.mebbly-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "mebbly-Public-a"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id = aws_vpc.mebbly-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "mebbly-Public-c"
  }
}

# Private Subnet

resource "aws_subnet" "private_subnet_a" {
  vpc_id = aws_vpc.mebbly-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "mebbly-Private-a"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id = aws_vpc.mebbly-vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "mebbly-Private-c"
  }
}

# DB Subnet

resource "aws_subnet" "redis_subnet_a" {
  vpc_id = aws_vpc.mebbly-vpc.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "mebbly-REDIS-a"
  }
}

resource "aws_subnet" "redis_subnet_c" {
  vpc_id = aws_vpc.mebbly-vpc.id
  cidr_block = "10.0.21.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "mebbly-REDIS-c"
  }
}

resource "aws_subnet" "db_subnet_a" {
  vpc_id = aws_vpc.mebbly-vpc.id
  cidr_block = "10.0.30.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "mebbly-DB-a"
  }
}

resource "aws_subnet" "db_subnet_c" {
  vpc_id = aws_vpc.mebbly-vpc.id
  cidr_block = "10.0.31.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "mebbly-DB-c"
  }
}

# Elastic IP
resource "aws_eip" "nat_ip_a" {
  depends_on = [
    aws_route_table.mebbly_public_rt_a
  ]

  vpc        = true
}

resource "aws_eip" "nat_ip_c" {
  depends_on = [
    aws_route_table.mebbly_public_rt_c
  ]

  vpc        = true
}

# NAT GATEWAY
resource "aws_nat_gateway" "mebbly_nat_gw_a" {
  depends_on = [
    aws_eip.nat_ip_a
  ]

  allocation_id = aws_eip.nat_ip_a.id

  subnet_id = aws_subnet.public_subnet_a.id

  tags = {
    Name = "mebbly-nat-a"
  }
}

resource "aws_nat_gateway" "mebbly_nat_gw_c" {
  depends_on = [
    aws_eip.nat_ip_c
  ]

  allocation_id = aws_eip.nat_ip_c.id

  subnet_id = aws_subnet.public_subnet_c.id

  tags = {
    Name = "mebbly-nat-c"
  }
}

# Routing Table
resource "aws_route_table" "mebbly_public_rt_a" {
  vpc_id = aws_vpc.mebbly-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mebbly-igw.id
  }

  tags = {
    Name = "mebbly-PUBLIC-RT-A"
  }
}

resource "aws_route_table" "mebbly_public_rt_c" {
  vpc_id = aws_vpc.mebbly-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mebbly-igw.id
  }

  tags = {
    Name = "mebbly-PUBLIC-RT-C"
  }
}

resource "aws_route_table" "mebbly_private_rt_a" {
  depends_on = [
    aws_nat_gateway.mebbly_nat_gw_a
  ]

  vpc_id = aws_vpc.mebbly-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mebbly_nat_gw_a.id
  }

  tags = {
    Name = "mebbly-PRIVATE-RT-A"
  }
}

resource "aws_route_table" "mebbly_private_rt_c" {
  depends_on = [
    aws_nat_gateway.mebbly_nat_gw_c
  ]

  vpc_id = aws_vpc.mebbly-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mebbly_nat_gw_c.id
  }

  tags = {
    Name = "mebbly-PRIVATE-RT-C"
  }
}

resource "aws_route_table" "mebbly_database_rt_a" {
  vpc_id = aws_vpc.mebbly-vpc.id

  tags = {
    Name = "mebbly-Database-RT-A"
  }
}

resource "aws_route_table" "mebbly_database_rt_c" {
  vpc_id = aws_vpc.mebbly-vpc.id

  tags = {
    Name = "mebbly-Database-RT-C"
  }
}

resource "aws_route_table_association" "mebbly_public_subnet_a_association" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.mebbly_public_rt_a.id
}

resource "aws_route_table_association" "mebbly_public_subnet_c_association" {
  subnet_id = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.mebbly_public_rt_c.id
}

resource "aws_route_table_association" "mebbly_private_subnet_a_association" {
  subnet_id = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.mebbly_private_rt_a.id
}

resource "aws_route_table_association" "mebbly_private_subnet_c_association" {
  subnet_id = aws_subnet.private_subnet_c.id 
  route_table_id = aws_route_table.mebbly_private_rt_c.id
}

resource "aws_route_table_association" "mebbly_redis_subnet_a_association" {
  subnet_id = aws_subnet.redis_subnet_a.id
  route_table_id = aws_route_table.mebbly_database_rt_a.id
}

resource "aws_route_table_association" "mebbly_redis_subnet_c_association" {
  subnet_id = aws_subnet.redis_subnet_c.id 
  route_table_id = aws_route_table.mebbly_database_rt_c.id
}

resource "aws_route_table_association" "mebbly_db_subnet_a_association" {
  subnet_id = aws_subnet.db_subnet_a.id
  route_table_id = aws_route_table.mebbly_database_rt_a.id
}

resource "aws_route_table_association" "mebbly_db_subnet_c_association" {
  subnet_id = aws_subnet.db_subnet_c.id 
  route_table_id = aws_route_table.mebbly_database_rt_c.id
}

### VPC END  ### 
