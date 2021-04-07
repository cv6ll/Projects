// Module specific variables
variable "name" {
  default = "test"
}

variable "environment" {
  default = "test"
}

variable "server_role" {
  default = "test"
}

variable "instance_type" {
  description = "Type of instance"
  default     = "t2.nano"
}

variable "instance_count" {
  description = "Define how many instances to launch"
  default     = "1"
}

variable "key_name" {
  description = "SSH keypair you've created"
  default     = "deployment-201407"
}

# variable "user_data" {
#   description = "User data that need to pass to the instance(s)"
# }

variable "security_group_id" {
  description = "Security Group you've created"
}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "ami_id" {
  description = "AMI used to spin-up this EC2 Instance"
}

variable "ebs_root_volume_type" {
  default = "gp2"
}

variable "ebs_root_volume_size" {
  default = "10"
}

variable "ebs_root_delete_on_termination" {
  default = "true"
}

variable "alarm_actions" {
  default     = ""
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
}

variable "instance_id" {
  description = "The instance being monitored."
  type        = "string"
}
