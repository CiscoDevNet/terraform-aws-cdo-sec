data "aws_partition" "current" {}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "sec-ssm-role" {
  name        = "${var.env}-${var.instance_name}-sec-ssm-role"
  path        = "/"
  description = "AWS IAM Role required for SSM managed access to the SEC"
  tags = merge(var.tags, {
    Name : "${var.env}-sec-ssm-role"
  })

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "sec-ssm-role" {
  role       = aws_iam_role.sec-ssm-role.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

resource "aws_iam_instance_profile" "sec-ssm-instance-profile" {
  name = "${var.env}-${var.instance_name}-sec-ssm-instance-profile"
  role = aws_iam_role.sec-ssm-role.name
}
