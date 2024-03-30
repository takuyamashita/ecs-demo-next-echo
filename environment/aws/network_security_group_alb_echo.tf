resource "aws_security_group" "alb_echo" {
  vpc_id      = aws_vpc.main.id
  name_prefix = "alb-echo-"

  tags = {
    Name = "alb-echo"
  }
}

resource "aws_security_group_rule" "alb_echo_ingress_443" {
  security_group_id = aws_security_group.alb_echo.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_echo_ingress_80" {
  security_group_id = aws_security_group.alb_echo.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_echo_egress_next" {
  security_group_id        = aws_security_group.alb_echo.id
  type                     = "egress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.next.id
}

resource "aws_security_group_rule" "alb_echo_egress_echo" {
  security_group_id        = aws_security_group.alb_echo.id
  type                     = "egress"
  from_port                = 1323
  to_port                  = 1323
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.echo.id
}