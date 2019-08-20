provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

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