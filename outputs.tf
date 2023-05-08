output "instance_id" {
  description = "The ID of the SEC instance. Use this ID to connect to your SEC instance for debugging purposes using AWS SSM (See [the AWS docs](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with.html) for details on how to connect using AWS SSM)."
  value       = aws_instance.sec.id
}

output "sec_fqdn" {
  description = "The Fully Qualified Domain Name the SEC is accessible from. When configuring logging, you can use any of the IP addresses this DNS record resolves to."
  value       = aws_route53_record.sec-dns.fqdn
}