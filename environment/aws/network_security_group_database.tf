resource "aws_security_group" "database" {
  vpc_id = aws_vpc.main.id
  name_prefix = "database-"

  tags = {
    Name = "database"
  }
}

resource "aws_security_group_rule" "database_ingress_echo" {
  security_group_id = aws_security_group.database.id
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = aws_security_group.echo.id
}
