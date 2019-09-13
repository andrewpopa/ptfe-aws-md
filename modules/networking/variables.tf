# Networking

variable "vpc_block" {
  default = "172.16.0.0/16"
}

variable "sub_block_a" {
  default = "172.16.10.0/24"
}

variable "sub_block_b" {
  default = "172.16.11.0/24"
}

variable "a_zone_a" {
  default = "eu-central-1a"
}

variable "a_zone_b" {
  default = "eu-central-1b"
}

variable "alb_name" {
  default = "ptfe-lb"
}

variable "tg_name" {
  default = "ptfe-target-group"
}

variable "tg_name_admin" {
  default = "ptfe-target-group-admin"
}


variable "ptfe_id" {
  default = ""
}
