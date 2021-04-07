resource "aws_vpc" "promgraf_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.app_env}-promgraf VPC"
  }
}

resource "aws_internet_gateway" "promgraf_gateway" {
  vpc_id = "${aws_vpc.promgraf_vpc.id}"
  tags = {
    Name = "${var.app_env}-promgraf Gateway"
  }
}

resource "aws_route" "public_access" {
  route_table_id         = "${aws_vpc.promgraf_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.promgraf_gateway.id}"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.promgraf_vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.app_env}-Public subnet"
  }
}

resource "aws_eip" "nat_ip" {

}

resource "aws_nat_gateway" "promgraf_nat" {
  allocation_id = "${aws_eip.nat_ip.id}"
  subnet_id     = "${aws_subnet.public_subnet.id}"
}

resource "aws_route_table" "promgraf_route" {
  vpc_id = "${aws_vpc.promgraf_vpc.id}"
  tags = {
    Name = "${var.app_env}-Private route table"
  }
}

resource "aws_route" "private_access" {
  route_table_id         = "${aws_route_table.promgraf_route.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_nat_gateway.promgraf_nat.id}"
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = "${aws_vpc.promgraf_vpc.id}"
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "${var.app_env}-Private subnet"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_vpc.promgraf_vpc.main_route_table_id}"
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.promgraf_route.id}"
}
