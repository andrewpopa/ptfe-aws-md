provider "aws" {}

# Networking
module "networking" {
  source = "./modules/networking/"
}

# EC2
module "ec2" {
  vpc_security_group_ids = ["${module.networking.vpc_security_group_ids}"]
  subnet_id              = "${module.networking.subnet_id}"
  a_zone                 = "${module.networking.a_zone}"
  source                 = "./modules/ec2/"
}

# Silent installation or restore
module "silent" {
  private_ip = "${module.ec2.ptfe_private_ip}"
  public_ip  = "${module.ec2.ptfe_public_ip}"
  source     = "./modules/silent/"
}


# DNS
module "dns" {
  public_ip = "${module.ec2.ptfe_public_ip}"
  source    = "./modules/dns/"
}
