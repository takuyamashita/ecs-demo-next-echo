resource "aws_security_group" "endpoint" {
  vpc_id = aws_vpc.main.id
  name_prefix = "endpoint-"

  tags = {
    Name = "endpoint"
  }
}

resource "aws_security_group_rule" "endpoint_ingress_all" {
  security_group_id = aws_security_group.endpoint.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "endpoint_egress_all" {
  security_group_id = aws_security_group.endpoint.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}