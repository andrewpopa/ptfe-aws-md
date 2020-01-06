# EC2
resource "aws_key_pair" "ec2" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

resource "aws_instance" "ptfe_cloud_prod_mode" {
  ami                         = "${var.ami_type}"
  instance_type               = "${var.ec2_instance["type"]}"
  vpc_security_group_ids      = ["${var.vpc_security_group_ids}"]
  key_name                    = "${aws_key_pair.ec2.key_name}"
  subnet_id                   = "${var.subnet_id}"
  associate_public_ip_address = "true"

  root_block_device {
    volume_type = "${var.ec2_instance["root_hdd_type"]}"
    volume_size = "${var.ec2_instance["root_hdd_size"]}"
    delete_on_termination = true
  }

  user_data = "${file("scripts/mount_ebs.sh")}"
}

resource "aws_ebs_volume" "ptfe_cloud_volume_db" {
  availability_zone = "${var.a_zone}"
  type              = "${var.ec2_instance["ebs_hdd_type"]}"
  size              = "${var.ec2_instance["ebs_hdd_size"]}"
}

resource "aws_volume_attachment" "ptfe_volume_db" {
  device_name = "${var.ec2_instance["ebs_hdd_name1"]}"
  instance_id = "${aws_instance.ptfe_cloud_prod_mode.id}"
  volume_id   = "${aws_ebs_volume.ptfe_cloud_volume_db.id}"
}

resource "aws_ebs_volume" "ptfe_cloud_volume_replica" {
  depends_on = ["aws_volume_attachment.ptfe_volume_db"]
  availability_zone = "${var.a_zone}"
  type              = "${var.ec2_instance["ebs_hdd_type"]}"
  size              = "${var.ec2_instance["ebs_hdd_size"]}"
}

resource "aws_volume_attachment" "ptfe_volume_replica" {
  device_name = "${var.ec2_instance["ebs_hdd_name2"]}"
  instance_id = "${aws_instance.ptfe_cloud_prod_mode.id}"
  volume_id   = "${aws_ebs_volume.ptfe_cloud_volume_replica.id}"
}