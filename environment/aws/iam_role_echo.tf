resource "aws_iam_role" "echo" {
  name_prefix = "echo-"

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

/*
resource "aws_iam_role_policy" "echo" {
  name_prefix = "echo-"
  role = aws_iam_role.echo.name

  policy = data.aws_iam_policy_document.echo.json
}

data "aws_iam_policy_document" "echo" {}
*/