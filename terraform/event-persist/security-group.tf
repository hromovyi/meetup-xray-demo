resource "aws_security_group_rule" "allow_inbound_connection" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lambda-security-group.id
}

resource "aws_security_group_rule" "allow_outbound_connection" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lambda-security-group.id
}

resource "aws_security_group" "lambda-security-group" {
  name        = "${local.function_name}-security-group"
  description = "Security group for ${local.function_name}"
}
