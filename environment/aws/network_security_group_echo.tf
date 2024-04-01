resource "aws_security_group" "echo" {
  vpc_id      = aws_vpc.main.id
  name_prefix = "echo-"

  tags = {
    Name = "echo"
  }
}

resource "aws_security_group_rule" "echo_ingress_next" {
  security_group_id        = aws_security_group.echo.id
  type                     = "ingress"
  from_port                = 1323
  to_port                  = 1323
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.next.id
}

resource "aws_security_group_rule" "echo_ingress_alb_front" {
  security_group_id        = aws_security_group.echo.id
  type                     = "ingress"
  from_port                = 1323
  to_port                  = 1323
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_front.id
}

resource "aws_security_group_rule" "echo_ingress_alb_echo" {
  security_group_id        = aws_security_group.echo.id
  type                     = "ingress"
  from_port                = 1323
  to_port                  = 1323
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_echo.id
}

resource "aws_security_group_rule" "echo_egress_database" {
  security_group_id        = aws_security_group.echo.id
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.database.id
}

resource "aws_security_group_rule" "echo_egress_all" {
  security_group_id = aws_security_group.echo.id
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}