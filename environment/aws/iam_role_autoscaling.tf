resource "aws_iam_role" "autoscaling" {
  name_prefix = "autoscaling-ecs-"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs.application-autoscaling.amazonaws.com",
        },
        Action = "sts:AssumeRole",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "autoscaling" {
  role       = aws_iam_role.autoscaling.name
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSApplicationAutoscalingECSServicePolicy"
}