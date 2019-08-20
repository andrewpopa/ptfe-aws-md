output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${aws_vpc.main_vpc.*.id}"
}

output "vpc_security_group_ids" {
  value = "${aws_security_group.sg_cloud_prod_mode.id}"
}

output "subnet_id" {
  value = "${aws_subnet.main_sub.id}"
}

output "a_zone" {
  value = "${var.a_zone}"
}
