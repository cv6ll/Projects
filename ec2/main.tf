resource "aws_instance" "ec2" {
  ami                    = "${var.ami_id}"
  count                  = "${var.instance_count}"
  vpc_security_group_ids = "${var.security_group_id}"
  key_name               = "${var.key_name}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${element(split(",", var.subnet_id), 0 % 2)}"
  user_data = file(format("%s/init_grafana.tpl",path.module))

  root_block_device {
    volume_type           = "${var.ebs_root_volume_type}"
    volume_size           = "${var.ebs_root_volume_size}"
    delete_on_termination = "${var.ebs_root_delete_on_termination}"
  }
    
  tags = {
    Name        = "${var.environment}-${var.name}-${format("%01d", count.index + 1)}"
    environment = "${var.environment}"
  }
}
output "private_ip" {
  value = "${join(",", aws_instance.ec2.*.private_ip)}"
}

output "private_ip_log" {
  value = "${join(" ", aws_instance.ec2.*.private_ip)}"
}

output "public_ip" {
  value = "${join("", aws_instance.ec2.*.public_ip)}"
}

output "private_ip1" {
  value = aws_instance.ec2.0.private_ip
}

output "ec2_id" {
  value = "${join(",", aws_instance.ec2.*.id)}"
}
