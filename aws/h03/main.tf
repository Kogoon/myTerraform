provider "aws" {
  region = "ap-northeast-2"
}

### VPC Start ###

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = "KOGOON-VPC"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "KOGOON_IGW"    
  }
}

# Subnet Modules?
# Multi-AZ
# Public Subnet
resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Kogoon-Public-a"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "Kogoon-Public-c"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Kogoon-Private-a"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "Kogoon-Private-c"
  }
}

resource "aws_subnet" "db_subnet_a" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Kogoon-DB-a"
  }
}

resource "aws_subnet" "db_subnet_c" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "Kogoon-DB-c"
  }
}
# Private Subnet

# DB Subnet


### VPC END  ### 


### Instance Start ###



### Instance End  ###