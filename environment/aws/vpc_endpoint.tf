resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.ap-northeast-1.logs"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [aws_security_group.endpoint.id]
  subnet_ids = [aws_subnet.endpoint_1a.id, aws_subnet.endpoint_1c.id]
  
  tags = {
    Name = "cloudwatch_logs"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [aws_security_group.endpoint.id]
  subnet_ids = [aws_subnet.endpoint_1a.id, aws_subnet.endpoint_1c.id]
  tags = {
    Name = "ecr_dkr"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [aws_security_group.endpoint.id]
  subnet_ids = [aws_subnet.endpoint_1a.id, aws_subnet.endpoint_1c.id]
  tags = {
    Name = "ecr_api"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [aws_route_table.web_application_1a.id, aws_route_table.web_application_1c.id]

  tags = {
    "Name" = "s3"
  }
}
