variable "instance_size" {
  description = "Size of the EC2 instance used to run the SEC (see the [CDO docs](https://docs.defenseorchestrator.com/#!t_install-a-cdo-connector-to-support-an-on-premises-sec-using-your-vm-image1.html) for requirements). Allowed values: \"r5a.xlarge\", \"r5a.2xlarge\", \"r5a.4xlarge\", \"r5a.8xlarge\", \"r5a.12xlarge\". We recommend using r5a.xlarge (the default)."
  type        = string
  default     = "r5a.xlarge"

  validation {
    condition     = contains(["r5a.xlarge", "r5a.2xlarge", "r5a.4xlarge", "r5a.8xlarge", "r5a.12xlarge"], var.instance_size)
    error_message = "Invalid instance size. Allowed values are: \"r5a.xlarge\", \"r5a.2xlarge\", \"r5a.4xlarge\", \"r5a.8xlarge\", \"r5a.12xlarge\". We recommend using r5a.xlarge (the default)."
  }
}

variable "env" {
  description = "A user-defined string to indicate the environment."
  type        = string
  default     = "prod"
}

variable "instance_name" {
  description = "The name to give the SEC instance (the instance created will be prefixed with `env`, and suffixed with `sec`)."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy the SEC instance in."
  type        = string
}

variable "subnet_id" {
  description = "The subnet to deploy the SEC instance in. The subnet must be in the VPC specified in `vpc_id`. We recommend deploying the SEC in a private subnet."
  type        = string
}

variable "public_subnet_id" {
  description = "The first public subnet of the VPC for the Load Balancer placed in front of the SEC. The subnet must be in the VPC specified in `vpc_id`. The subnet *must* be public; i.e., have an Internet Gateway attached."
  type        = string
}

variable "secondary_public_subnet_id" {
  description = "The secondary public subnet of the VPC for the Load Balancer placed in front of the SEC. The subnet must be in the VPC specified in `vpc_id`. The subnet *must* be public; i.e., have an Internet Gateway attached. Needs to be in a different AZ to the subnet specified in `subnet_id`."
  type        = string
}

variable "tags" {
  description = "The tags to add to all of the resources created by this Terraform module."
  default = {
    ApplicationName = "Cisco Defense Orchestrator"
    ServiceName     = "SEC"
  }
  type = map(string)
}

variable "cdo_bootstrap_data" {
  description = "Base64-encoded CDO Bootstrap Data. You can generate this using [CDO](https://edge.us.cdo.cisco.com/content/docs/index.html#!t_install-a-cdo-connector-to-support-an-on-premises-sec-using-your-vm-image1.html) (see Step 19)."
  type        = string
}

variable "sec_bootstrap_data" {
  description = "Base64-encoded CDO Bootstrap Data. You can generate this using [the CDO docs](https://edge.us.cdo.cisco.com/content/docs/index.html#!t_install-the-secure-event-connector-on-your-cdo-connector-virtual-machine.html) (see Step 5)."
  type        = string
}

variable "dns_name" {
  description = "The cloud-delivered SEC uses an NLB to forward traffic through to the SEC. Specify the domain name here. The DNS name should be a sub-domain of the domain managed by the hosted zone specified in hosted_zone_id."
  type        = string
}

variable "hosted_zone_id" {
  description = "The ID of a Route53 hosted zone in your AWS account where we can create DNS entries for the SEC. We require that the SEC be deployed in a hosted zone managed by Route53. This is required for us to be able to generate and auto-renew certificates."
  type        = string
}

variable "cidr" {
  description = "CIDR to allow traffic from to SEC instance. Restrict this to the subnet the firewalls and SD-WAN devices you want to send syslog data from are in. We *do not* recommend using the default value, as this will allow anybody on the internet to send logs to your SEC."
  default     = "0.0.0.0/0"
  type        = string
}