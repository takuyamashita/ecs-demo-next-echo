resource "aws_iam_role" "ecs_echo_task_execution" {
  name_prefix = "ecs-echo-task-execution-"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

}

resource "aws_iam_role_policy_attachment" "ecs_echo_task_execution" {
  role       = aws_iam_role.ecs_echo_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_echo_task_execution_pull_image" {
  role       = aws_iam_role.ecs_echo_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}

resource "aws_iam_role_policy" "ecs_echo_task_execution" {
  name_prefix = "ecs-echo-task-execution-"
  role        = aws_iam_role.ecs_echo_task_execution.name
  policy      = data.aws_iam_policy_document.ecs_echo_task_execution.json
}

data "aws_iam_policy_document" "ecs_echo_task_execution" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      //"kms:Decrypt"
    ]

    resources = [
      "${aws_db_instance.main.master_user_secret[0].secret_arn}",
      //"arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${aws_db_instance.main.master_user_secret[0].kms_key_id}"
    ]
  }
}