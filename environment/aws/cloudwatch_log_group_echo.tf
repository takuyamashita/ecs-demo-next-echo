resource "aws_cloudwatch_log_group" "echo" {
  name_prefix = "/ecs/echo-"
}