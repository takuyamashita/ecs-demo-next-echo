resource "aws_iam_role" "next" {
  name_prefix = "next-"

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

resource "aws_iam_role_policy" "next" {
  name_prefix = "next"
  role = aws_iam_role.next.name

  policy = data.aws_iam_policy_document.next.json
}

data "aws_iam_policy_document" "next" {}