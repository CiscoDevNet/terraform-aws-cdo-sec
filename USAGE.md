## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.sec-acm-cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_iam_instance_profile.sec-ssm-instance-profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.sec-ssm-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.sec-ssm-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.sec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_lb.sec-aws-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.sec-aws-lb-listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.sec-aws-lb-listener-non-tls-tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.sec-aws-lb-listener-udp-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.sec-aws-lb-listener-udp-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.sec-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.sec-udp-1-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.sec-udp-2-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.sec-tg-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.sec-udp-1-tg-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.sec-udp-2-tg-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_route53_record.sec-acm-cert-validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.sec-dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.sec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.sec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy.AmazonSSMManagedInstanceCore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_vpc.sec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [template_file.bootstrap](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cdo_bootstrap_data"></a> [cdo\_bootstrap\_data](#input\_cdo\_bootstrap\_data) | Base64-encoded CDO Bootstrap Data. You can generate this using [CDO](https://edge.us.cdo.cisco.com/content/docs/index.html#!t_install-a-cdo-connector-to-support-an-on-premises-sec-using-your-vm-image1.html) (see Step 19). | `any` | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR to allow traffic from to SEC instance. Restrict this to the subnet the firewalls and SD-WAN devices you want to send syslog data from are in. We *do not* recommend using the default value, as this will allow anybody on the internet to send logs to your SEC. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | The cloud-delivered SEC uses an NLB to forward traffic through to the SEC. Specify the domain name here. The DNS name should be a sub-domain of the domain managed by the hosted zone specified in hosted\_zone\_id. | `any` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | A user-defined string to indicate the environment. | `string` | `"prod"` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | The ID of a Route53 hosted zone in your AWS account where we can create DNS entries for the SEC. We require that the SEC be deployed in a hosted zone managed by Route53. This is required for us to be able to generate and auto-renew certificates. | `any` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name to give the SEC instance (the instance created will be prefixed with `env`, and suffixed with `sec`). | `any` | n/a | yes |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | Size of the EC2 instance used to run the SEC (see the [CDO docs](https://docs.defenseorchestrator.com/#!t_install-a-cdo-connector-to-support-an-on-premises-sec-using-your-vm-image1.html) for requirements). Allowed values: "r5a.xlarge", "r5a.2xlarge", "r5a.4xlarge", "r5a.8xlarge", "r5a.12xlarge". We recommend using r5a.xlarge (the default). | `string` | `"r5a.xlarge"` | no |
| <a name="input_public_subnet_id"></a> [public\_subnet\_id](#input\_public\_subnet\_id) | The first public subnet of the VPC for the Load Balancer placed in front of the SEC. The subnet must be in the VPC specified in `vpc_id`. The subnet *must* be public; i.e., have an Internet Gateway attached. | `any` | n/a | yes |
| <a name="input_sec_bootstrap_data"></a> [sec\_bootstrap\_data](#input\_sec\_bootstrap\_data) | Base64-encoded CDO Bootstrap Data. You can generate this using [the CDO docs](https://edge.us.cdo.cisco.com/content/docs/index.html#!t_install-the-secure-event-connector-on-your-cdo-connector-virtual-machine.html) (see Step 5). | `any` | n/a | yes |
| <a name="input_secondary_public_subnet_id"></a> [secondary\_public\_subnet\_id](#input\_secondary\_public\_subnet\_id) | The secondary public subnet of the VPC for the Load Balancer placed in front of the SEC. The subnet must be in the VPC specified in `vpc_id`. The subnet *must* be public; i.e., have an Internet Gateway attached. Needs to be in a different AZ to the subnet specified in `subnet_id`. | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet to deploy the SEC instance in. The subnet must be in the VPC specified in `vpc_id`. We recommend deploying the SEC in a private subnet. | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to add to all of the resources created by this Terraform module. | `map` | <pre>{<br>  "ApplicationName": "Cisco Defense Orchestrator",<br>  "ServiceName": "SEC"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to deploy the SEC instance in. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the SEC instance. Use this ID to connect to your SEC instance for debugging purposes using AWS SSM (See [the AWS docs](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with.html) for details on how to connect using AWS SSM). |
| <a name="output_sec_fqdn"></a> [sec\_fqdn](#output\_sec\_fqdn) | The Fully Qualified Domain Name the SEC is accessible from. When configuring logging, you can use any of the IP addresses this DNS record resolves to. |
