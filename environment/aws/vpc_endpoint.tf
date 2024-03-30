resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.endpoint.id]
  subnet_ids          = [aws_subnet.endpoint_1a.id, aws_subnet.endpoint_1c.id]

  tags = {
    Name = "cloudwatch_logs"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.endpoint.id]
  subnet_ids          = [aws_subnet.endpoint_1a.id, aws_subnet.endpoint_1c.id]
  tags = {
    Name = "ecr_dkr"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.endpoint.id]
  subnet_ids          = [aws_subnet.endpoint_1a.id, aws_subnet.endpoint_1c.id]
  tags = {
    Name = "ecr_api"
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.endpoint.id]
  subnet_ids          = [aws_subnet.endpoint_1a.id, aws_subnet.endpoint_1c.id]
  tags = {
    Name = "ssm"
  }
}

resource "aws_vpc_endpoint" "secrets_manager" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.endpoint.id]
  subnet_ids          = [aws_subnet.endpoint_1a.id, aws_subnet.endpoint_1c.id]
  tags = {
    Name = "secrets_manager"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.next_1a.id,
    aws_route_table.next_1c.id,
    aws_route_table.echo_1a.id,
    aws_route_table.echo_1c.id,
  ]

  tags = {
    "Name" = "s3"
  }
}
