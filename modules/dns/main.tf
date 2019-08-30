provider "cloudflare" {
  email = "${var.email}"
  token = "${var.api_toke}"
}

resource "cloudflare_record" "ptfe" {
  domain = "${var.domain}"
  name   = "ptfe"
  value  = "${var.public_ip}"
  type   = "A"
  ttl    = 1
}