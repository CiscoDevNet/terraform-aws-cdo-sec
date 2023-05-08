resource "aws_lb" "sec-aws-lb" {
  name                       = "${var.env}-${var.instance_name}-sec-nlb"
  internal                   = "false"
  load_balancer_type         = "network"
  subnets                    = [var.public_subnet_id, var.secondary_public_subnet_id]
  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true

  tags = merge({
    Name = "${var.env}-${var.instance_name}-nlb"
  }, var.tags)
}

resource "aws_lb_target_group" "sec-tg" {
  name                              = "${var.env}-${var.instance_name}-sec-tg"
  target_type                       = "instance"
  port                              = 10125
  protocol                          = "TCP"
  vpc_id                            = var.vpc_id
  load_balancing_cross_zone_enabled = true
}

resource "aws_lb_target_group" "sec-udp-1-tg" {
  name                              = "${var.env}-${var.instance_name}-sec-udp-1"
  target_type                       = "instance"
  port                              = 10025
  protocol                          = "UDP"
  vpc_id                            = var.vpc_id
  load_balancing_cross_zone_enabled = true
}

resource "aws_lb_target_group" "sec-udp-2-tg" {
  name                              = "${var.env}-${var.instance_name}-sec-udp-2"
  target_type                       = "instance"
  port                              = 10425
  protocol                          = "UDP"
  vpc_id                            = var.vpc_id
  load_balancing_cross_zone_enabled = true
}

resource "aws_lb_target_group_attachment" "sec-tg-attachment" {
  target_group_arn = aws_lb_target_group.sec-tg.arn
  target_id        = aws_instance.sec.id
  port             = 10125
}

resource "aws_lb_target_group_attachment" "sec-udp-1-tg-attachment" {
  target_group_arn = aws_lb_target_group.sec-udp-1-tg.arn
  target_id        = aws_instance.sec.id
  port             = 10025
}

resource "aws_lb_target_group_attachment" "sec-udp-2-tg-attachment" {
  target_group_arn = aws_lb_target_group.sec-udp-2-tg.arn
  target_id        = aws_instance.sec.id
  port             = 10425
}

resource "aws_lb_listener" "sec-aws-lb-listener" {
  load_balancer_arn = aws_lb.sec-aws-lb.id
  port              = 10125
  protocol          = "TLS"
  certificate_arn   = aws_acm_certificate.sec-acm-cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sec-tg.arn
  }
}

resource "aws_lb_listener" "sec-aws-lb-listener-non-tls-tcp" {
  load_balancer_arn = aws_lb.sec-aws-lb.id
  port              = 10126
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sec-tg.arn
  }
}

resource "aws_lb_listener" "sec-aws-lb-listener-udp-1" {
  load_balancer_arn = aws_lb.sec-aws-lb.id
  port              = 10025
  protocol          = "UDP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sec-udp-1-tg.arn
  }
}

resource "aws_lb_listener" "sec-aws-lb-listener-udp-2" {
  load_balancer_arn = aws_lb.sec-aws-lb.id
  port              = 10425
  protocol          = "UDP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sec-udp-2-tg.arn
  }
}