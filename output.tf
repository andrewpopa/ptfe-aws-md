output "aws_ptfe_public_ip" {
  value = "${module.ec2.ptfe_public_ip}"
}
output "aws_ptfe_private_ip" {
  value = "${module.ec2.ptfe_private_ip}"
}

output "aws_ptfe_dns" {
  value = "${module.ec2.ptfe_dns}"
}

output "ptfe_fqdn" {
  value = "${module.silent.fqdn}"
}
