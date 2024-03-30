resource "aws_ssm_parameter" "ecr_next" {
  name  = "/next/ecr"
  type  = "String"
  value = aws_ecr_repository.next.repository_url
}

resource "aws_ssm_parameter" "ecr_echo" {
  name  = "/echo/ecr"
  type  = "String"
  value = aws_ecr_repository.echo.repository_url
}