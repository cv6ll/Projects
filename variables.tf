variable "app_env" {
  description = "Application environment"
  default     = "test"
}

variable "aws_region" {
  description = "AWS regione where launch servers"
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "aws profile"
  default     = "default"
}

variable "aws_amis" {
  default = {
    eu-central-1 = "ami-0767046d1677be5a0"
  }
}

variable "instance_type" {
  default = "t2.micro"
}
