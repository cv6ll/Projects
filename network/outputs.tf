output "promgraf_vpc_id" {
  value = "${aws_vpc.promgraf_vpc.id}"
}

output "promgraf_private_subnet_id" {
  value = "${aws_subnet.private_subnet.id}"
}

output "promgraf_public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "promgraf_private_subnet_cidr" {
  value = "${aws_subnet.private_subnet.cidr_block}"
}

output "promgraf_public_subnet_cidr" {
  value = "${aws_subnet.public_subnet.cidr_block}"
}
