resource "aws_security_group" "next" {
  vpc_id      = aws_vpc.main.id
  name_prefix = "next-"

  tags = {
    Name = "next"
  }
}

resource "aws_security_group_rule" "next_ingress_alb_front" {
  security_group_id        = aws_security_group.next.id
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_front.id
}

resource "aws_security_group_rule" "next_egress_echo" {
  security_group_id        = aws_security_group.next.id
  type                     = "egress"
  from_port                = 1323
  to_port                  = 1323
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.echo.id
}

resource "aws_security_group_rule" "next_ingress" {
  security_group_id = aws_security_group.next.id
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "next_egress_all" {
  security_group_id = aws_security_group.next.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}