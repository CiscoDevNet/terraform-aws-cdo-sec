resource "aws_route53_record" "sec-dns" {
  zone_id = var.hosted_zone_id
  name    = var.dns_name
  type    = "CNAME"
  records = [aws_lb.sec-aws-lb.dns_name]
  ttl     = 300
}