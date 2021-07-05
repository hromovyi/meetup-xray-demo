resource "aws_iam_instance_profile" "instance_profile" {
  role = aws_iam_role.instance_role.name
}

resource "aws_iam_role" "instance_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "x_ray" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

resource "aws_iam_role_policy_attachment" "beanstalk_web" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

data "aws_iam_policy_document" "resources" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "resources" {
  name   = "${local.application_name}-resources"
  policy = data.aws_iam_policy_document.resources.json
}

resource "aws_iam_role_policy_attachment" "resources" {
  role       = aws_iam_role.instance_role.name
  policy_arn = aws_iam_policy.resources.arn
}
