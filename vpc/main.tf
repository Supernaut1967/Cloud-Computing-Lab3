# modules/vpc/main.tf

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_identifier == "blue" ? "Vpc-Blue" : "Vpc-Green"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw-tf"
  }
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.subnet_cidr_blocks)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.vpc_identifier == "blue" ? "SN-Public-Blue-${count.index}" : "SN-Public-Green-${count.index}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "RT-Public"
  }
}

resource "aws_route_table_association" "public_sn_rt" {
  count        = length(var.subnet_cidr_blocks)
  subnet_id    = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
