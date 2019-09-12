provider "cloudflare" {
  email = "${var.email}"
  token = "${var.api_toke}"
}

resource "cloudflare_record" "ptfe" {
  domain = "${var.domain}"
  name   = "ptfe"
  value  = "${var.alb_dns_name}"
  type   = "CNAME"
  ttl    = 1
}