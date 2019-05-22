#####
# Terraform Script - Demo at Team Meeting June 19
# Author - Steve Walker
# Version - 

#####
#Providers
#####

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

#####
#Data
#####

#data "aws_availability_zones" "available" {}

#####
#Resources
#####

#Networking

# NETWORKING #

resource "aws_vpc" "main_vpc" {
  cidr_block       = "${var.cidr}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "Test"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "${var.subnet_cidr}"
  

  tags = {
    Name = "Test"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
    Name = "Test"
  }
}

resource "aws_security_group" "mssql_sg" {
  name        = "mssql_rdp"
  description = "Allow RDP"
  vpc_id      = "${aws_vpc.main_vpc.id}"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr_blocks}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.cidr_blocks}"]
  }

  tags {
    Name = "Test"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "${var.cidr_blocks}"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Test"
  }
}

resource "aws_main_route_table_association" "rout" {
  vpc_id         = "${aws_vpc.main_vpc.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}

# EC2 #

resource "aws_instance" "mssql" {
  ami                         = "${var.aws_ami}"
  instance_type               = "${var.aws_instance_size}"
  subnet_id                   = "${aws_subnet.subnet.id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.mssql_sg.id}"]
  key_name                    = "${var.keypair}"
  get_password_data           = "true"

  tags { 
    Name = "${var.ec2_name}" 
  }
}



