output "ptfe_public_ip" {
  value = "${aws_instance.ptfe_cloud_prod_mode.public_ip}"
}

output "ptfe_private_ip" {
  value = "${aws_instance.ptfe_cloud_prod_mode.private_ip}"
}

output "ptfe_dns" {
  value = "${aws_instance.ptfe_cloud_prod_mode.public_dns}"
}