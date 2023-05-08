terraform {
  required_version = "1.3.9"
  required_providers {
    aws = "~> 4.66.1"
    template = "~> 2.2.0"
  }
}

data "aws_ami" "sec" {
  filter {
    name   = "name"
    values = ["sec*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["692314432491"]

  most_recent = true
}

resource "aws_security_group" "sec" {
  vpc_id      = var.vpc_id
  name        = "${var.env}-${var.instance_name}-sec-sg"
  description = "Security Group that allows all egress, and ingress into UDP ports [10025, 10425] and TCP port 10125"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10025
    to_port     = 10025
    protocol    = "udp"
    cidr_blocks = [var.cidr]
  }

  // netflow
  ingress {
    from_port   = 10425
    to_port     = 10425
    protocol    = "udp"
    cidr_blocks = [var.cidr]
  }

  ingress {
    from_port   = 10125
    to_port     = 10125
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
  }

  tags = merge({
    Name = "${var.env}-${var.instance_name}-sec-sg"
  }, var.tags)
}

data "template_file" "bootstrap" {
  template = file("${path.module}/bootstrap_sec.tpl")
  vars = {
    cdo_bootstrap_data = var.cdo_bootstrap_data
    sec_bootstrap_data = var.sec_bootstrap_data
  }
}

resource "aws_instance" "sec" {
  ami                  = data.aws_ami.sec.id
  instance_type        = var.instance_size
  iam_instance_profile = aws_iam_instance_profile.sec-ssm-instance-profile.id
  tags = merge({
    Name = "${var.env}-${var.instance_name}-sec"
  }, var.tags)
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.sec.id]
  user_data              = data.template_file.bootstrap.rendered
}
