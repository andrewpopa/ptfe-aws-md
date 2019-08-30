# EC2
variable "key_name" {}

variable "public_key" {}

variable "ami_type" {
  default     = "ami-0085d4f8878cddc81"
}

variable "ec2_instance" {
  type = "map"
  default = {
    "type"          = "m5.large"
    "root_hdd_size" = 50
    "root_hdd_type" = "gp2"
    "ebs_hdd_size"  = 100
    "ebs_hdd_type"  = "gp2"
    "ebs_hdd_name1"  = "/dev/xvdb"
    "ebs_hdd_name2"  = "/dev/xvdc"
  }
}

# Default variables declaration
variable "vpc_security_group_ids" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "a_zone" {
  default = ""
}