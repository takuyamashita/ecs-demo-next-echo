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

resource "aws_ssm_parameter" "db_user" {
  name  = "/db/user"
  type  = "String"
  value = "${aws_db_instance.main.master_user_secret[0].secret_arn}:username::"
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/db/password"
  type  = "String"
  value = "${aws_db_instance.main.master_user_secret[0].secret_arn}:password::"
}

resource "aws_ssm_parameter" "db_host" {
  name  = "/db/host"
  type  = "String"
  value = aws_db_instance.main.address
}

resource "aws_ssm_parameter" "db_port" {
  name  = "/db/port"
  type  = "String"
  value = "3306"
}

resource "aws_ssm_parameter" "db_name" {
  name  = "/db/name"
  type  = "String"
  value = aws_db_instance.main.db_name
}

resource "aws_ssm_parameter" "echo_log_group_name" {
  name  = "/echo/log_group_name"
  type  = "String"
  value = aws_cloudwatch_log_group.echo.name
}

resource "aws_ssm_parameter" "echo_api_endpoint" {
  name  = "/echo/api_endpoint"
  type  = "String"
  value = "http://${aws_lb.alb_echo.dns_name}:${aws_lb_listener.alb_echo.port}"
}

resource "aws_ssm_parameter" "next_log_group_name" {
  name  = "/next/log_group_name"
  type  = "String"
  value = aws_cloudwatch_log_group.next.name
}

resource "aws_ssm_parameter" "next_task_execution_role_arn" {
  name  = "/next/execution_role_arn"
  type  = "String"
  value = aws_iam_role.ecs_next_task_execution.arn
}

resource "aws_ssm_parameter" "next_task_role_arn" {
  name  = "/next/task_role_arn"
  type  = "String"
  value = aws_iam_role.next.arn
}

resource "aws_ssm_parameter" "echo_task_execution_role_arn" {
  name  = "/echo/execution_role_arn"
  type  = "String"
  value = aws_iam_role.ecs_echo_task_execution.arn
}

resource "aws_ssm_parameter" "echo_task_role_arn" {
  name  = "/echo/task_role_arn"
  type  = "String"
  value = aws_iam_role.echo.arn
}

