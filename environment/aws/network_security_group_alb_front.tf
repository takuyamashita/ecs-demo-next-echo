resource "aws_security_group" "alb_front" {
  vpc_id      = aws_vpc.main.id
  name_prefix = "alb-front-"

  tags = {
    Name = "alb-front"
  }
}

resource "aws_security_group_rule" "alb_front_ingress_443" {
  security_group_id = aws_security_group.alb_front.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_front_ingress_80" {
  security_group_id = aws_security_group.alb_front.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_front_egress_next" {
  security_group_id        = aws_security_group.alb_front.id
  type                     = "egress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.next.id
}

resource "aws_security_group_rule" "alb_front_egress_echo" {
  security_group_id        = aws_security_group.alb_front.id
  type                     = "egress"
  from_port                = 1323
  to_port                  = 1323
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.echo.id
}