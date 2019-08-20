# Networking

resource "aws_vpc" "main_vpc" {
  cidr_block           = "${var.vpc_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "main_sub" {
  vpc_id            = "${aws_vpc.main_vpc.id}"
  cidr_block        = "${var.sub_block}"
  availability_zone = "${var.a_zone}"

  tags = {
    Name = "ptfe-cloud-prod-mode"
  }
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
    Name = "main_gw"
  }
}

resource "aws_route_table" "main_routing_table" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main_gw.id}"
  }
}

resource "aws_main_route_table_association" "main" {
  route_table_id = "${aws_route_table.main_routing_table.id}"
  vpc_id         = "${aws_vpc.main_vpc.id}"
}

# Security group

resource "aws_security_group" "sg_cloud_prod_mode" {
  name   = "ptfe-cloud-prod-mode"
  vpc_id = "${aws_vpc.main_vpc.id}"

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}