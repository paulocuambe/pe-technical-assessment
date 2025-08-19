resource "aws_vpc" "pvt" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Private VPC"
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.pvt.id

  route {
    cidr_block           = aws_vpc.pvt.cidr_block
    network_interface_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pvt-default-rb"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.pvt.id

  tags = {
    Name = "internet-gtw"
  }
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.pvt.id
  route_table_id = aws_route_table.default.id
}

resource "aws_subnet" "pvt" {
  vpc_id                  = aws_vpc.pvt.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = false # making sure i don't get charged for public ips $$
  availability_zone       = "af-south-1a"

  tags = {
    Name = "SUB-1A-PVT"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.pvt.id
  cidr_block              = "10.0.20.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "af-south-1b"

  tags = {
    Name = "SUB-1B-PUB"
  }
}
