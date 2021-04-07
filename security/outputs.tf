output "promgraf1_sc_id" {
  value = "${aws_security_group.promgraf_sc_default.id}"
}

output "promgraf2_sc_id" {
  value = "${aws_security_group.promgraf_sc_esearch.id}"
}

output "promgraf3_sc_id" {
  value = "${aws_security_group.promgraf.id}"
}
