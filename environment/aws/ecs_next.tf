resource "aws_ecs_task_definition" "next" {
  family = "next"

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 512
  memory = 1024

  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  task_role_arn      = aws_iam_role.next.arn

  track_latest = true

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }


  container_definitions = jsonencode([
    {
      name      = "next"
      image     = "${aws_ecr_repository.next.repository_url}:v1"
      essential = true
      portMappings = [
        {
          name          = "http"
          protocol      = "tcp"
          appProtocol   = "http"
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-create-group"  = "true"
          "awslogs-group"         = "${aws_cloudwatch_log_group.next.name}"
          "awslogs-region"        = "ap-northeast-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_cluster" "next" {
  name = "next"

}

resource "aws_ecs_service" "next" {
  name             = "next"
  cluster          = aws_ecs_cluster.next.id
  task_definition  = aws_ecs_task_definition.next.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = [aws_subnet.web_application_1a.id, aws_subnet.web_application_1c.id]
    security_groups  = [aws_security_group.next.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.next_1.arn
    container_name   = "next"
    container_port   = 3000
  }

  lifecycle {
    ignore_changes = [desired_count, platform_version, load_balancer, task_definition]
  }
}
