resource "aws_acm_certificate" "sec-acm-cert" {
  domain_name       = var.dns_name
  validation_method = "DNS"

  tags = merge({
    Name = "${var.env}-${var.instance_name}-alb"
  }, var.tags)
}

resource "aws_route53_record" "sec-acm-cert-validation" {
  for_each = {
    for dvo in aws_acm_certificate.sec-acm-cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.hosted_zone_id
}