# LB

resource "aws_iam_server_certificate" "ptfe_cert" {
  name_prefix       = "ptfe-certificate"
  certificate_body  = "${file("${path.module}/files/cert1.pem")}"
  certificate_chain = "${file("${path.module}/files/chain1.pem")}"
  private_key       = "${file("${path.module}/files/privkey1.pem")}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "alb" {  
  name            = "${var.alb_name}"  
  subnets         = ["${aws_subnet.main_sub_a.id}", "${aws_subnet.main_sub_b.id}"]
  security_groups = ["${aws_security_group.sg_cloud_prod_mode.id}"]
  internal        = false 
}

// Frontend
resource "aws_lb_listener" "alb_listener_frontend" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${aws_iam_server_certificate.ptfe_cert.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb_target_frontend.arn}"
  }
}

resource "aws_lb_target_group" "alb_target_frontend" {  
  name     = "${var.tg_name}"  
  port     = "443"  
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id   = "${aws_vpc.main_vpc.id}"   
}

resource "aws_lb_target_group_attachment" "alb_attach_frontend" {
  target_group_arn = "${aws_lb_target_group.alb_target_frontend.arn}"
  target_id        = "${var.ptfe_id}"
  port             = 443
}

// Admin
resource "aws_lb_listener" "alb_listener_admin" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "8800"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${aws_iam_server_certificate.ptfe_cert.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb_target_admin.arn}"
  }
}

resource "aws_lb_target_group" "alb_target_admin" {  
  name     = "${var.tg_name_admin}"  
  port     = "8800"  
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id   = "${aws_vpc.main_vpc.id}"   
}

resource "aws_lb_target_group_attachment" "alb_attach_admin" {
  target_group_arn = "${aws_lb_target_group.alb_target_admin.arn}"
  target_id        = "${var.ptfe_id}"
  port             = 8800
}