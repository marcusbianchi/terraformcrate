# VPC
resource "aws_vpc" "crateVPC" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "ec2CrateVPC"
  }
}

# VPC Internet Gateway
resource "aws_internet_gateway" "crateIG" {
  vpc_id = aws_vpc.crateVPC.id
  tags = {
    Name = "ec2CrateIG"
  }
}

# Public subnet 1
resource "aws_subnet" "crate_public_sn_01" {
  vpc_id            = aws_vpc.crateVPC.id
  cidr_block        = var.subnet1_cidr_block
  availability_zone = var.sunet1_availability_zone
  tags = {
    Name = "crate_public_sn_01"
  }
}

# Routing table for public subnet 1
resource "aws_route_table" "create_public_sn_rt_01" {
  vpc_id = aws_vpc.crateVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.crateIG.id
  }
  tags = {
    Name = "create_public_sn_rt_01"
  }
}
# Associate the routing table to public subnet 1
resource "aws_route_table_association" "create_public_sn_rt_01_assn" {
  subnet_id      = aws_subnet.crate_public_sn_01.id
  route_table_id = aws_route_table.create_public_sn_rt_01.id
}

# Public subnet 2
resource "aws_subnet" "crate_public_sn_02" {
  vpc_id            = aws_vpc.crateVPC.id
  cidr_block        = var.subnet2_cidr_block
  availability_zone = var.sunet2_availability_zone
  tags = {
    Name = "crate_public_sn_02"
  }
}
# Routing table for public subnet 2
resource "aws_route_table" "create_public_sn_rt_02" {
  vpc_id = aws_vpc.crateVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.crateIG.id
  }
  tags = {
    Name = "create_public_sn_rt_02"
  }
}
# Associate the routing table to public subnet 2
resource "aws_route_table_association" "create_public_sn_rt_02_assn" {
  subnet_id      = aws_subnet.crate_public_sn_02.id
  route_table_id = aws_route_table.create_public_sn_rt_02.id
}

# EC2 Instance Security group
resource "aws_security_group" "crate_public_sg" {
  name   = "crate_public_sg"
  vpc_id = aws_vpc.crateVPC.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 4200
    to_port   = 4200
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 4300
    to_port   = 4300
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "tcp"
    cidr_blocks = [
    var.subnet1_cidr_block,var.subnet2_cidr_block]
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  tags = {
    Name = "crate_public_sg"
  }
}