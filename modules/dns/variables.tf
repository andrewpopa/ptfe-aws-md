variable "api_email" {
  description = "API email address"
  default     = ""
}

variable "api_token" {
  description = "API token for cloudflare"
  default     = ""
}

variable "cf_domain" {
  description = "Domain name which will be used"
  default     = "domain.com"
}

variable "cf_sub_domain" {
  description = "Sub-domain which will be used"
  default     = "subdomain"
}

variable "pointer" {
  description = "Point to infrastructure - ip or lb"
  default     = "1.1.1.1"
}

variable "record_type" {
  description = "DNS records type - A, CNAME"
  default     = "A"
}

variable "zone_id" {
  description = "Zone ID"
  default     = ""
}