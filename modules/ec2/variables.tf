# EC2
variable "key_name" {
  default = "andrei"
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIdRIGZBoLupNf3xvLZYWEMRkhoVOs7HjB80tbTH6b/k2BEQdvfmeSgMW0K4ezavCFyo6nehEPmY194QH4NllzlvfhbdpXrNWq3iXONB6pijuH0XryB/ZEm8tyw0nRXlAAVtqzaRbYVJg41VV5KcyyfBE7nzjmIql6A67d7Pij8yKuBzmpbMWNEuYvrIZCtHqlA4hmK+RyrzyfwMdyVXC0a2TLUkKBnaFMMBD+izfUDMDwolQ+NEZ3Bl3gWRrXMjirNVKXLzKRIeO44B2L/nmiZNI58KUiYJNVRFERP0rv9Ya+NvJXh8wonTbz1viWZ0oaKubbtYcLgPoc9I7buuf9"
}

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
  default = []
}

variable "subnet_id" {
  default = ""
}

variable "a_zone" {
  default = ""
}