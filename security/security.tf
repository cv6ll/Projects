resource "aws_security_group" "promgraf_sc_default" {
  name        = "promgraf_default_security_group"
  description = "Main security group for instances in public subnet"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_env}-promgraf default security group"
  }
}

resource "aws_security_group" "promgraf_sc_esearch" {
  name        = "promgraf_esearch_security_group"
  description = "Security group for Grafana-Prometheus stack instance"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.private_vpc_cidr}", "${var.public_vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_env}-Promgraf default security group"
  }
}

resource "aws_security_group" "promgraf" {
  name        = "promgraf_security_group"
  description = "Security group for Grafana-Prometheus cluster"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 9200
    to_port     = 9400
    protocol    = "tcp"
    cidr_blocks = ["${var.private_vpc_cidr}", "${var.public_vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_env}-Prom-Graf default security groups"
  }
}
