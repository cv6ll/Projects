provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  access_key = "eNTER KEY"
  secret_key = "ENTER KEY"
}

module "network" {
  source = "./network"
}

module "security" {
  source           = "./security"
  vpc_id           = module.network.promgraf_vpc_id
  private_vpc_cidr = module.network.promgraf_private_subnet_cidr
  public_vpc_cidr  = module.network.promgraf_public_subnet_cidr
}


module "GrafanaProm" {
  source               = "./ec2"
  instance_count       = "1"
  name                 = "Grafana-Prom"
  environment          = var.app_env
  instance_type        = var.instance_type
  key_name             = "test1"
  security_group_id    = [module.security.promgraf1_sc_id]
  subnet_id            = module.network.promgraf_public_subnet_id
  ami_id               = var.aws_amis[var.aws_region]
  instance_id = module.GrafanaProm.ec2_id
}
