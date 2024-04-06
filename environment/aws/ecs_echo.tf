resource "aws_ecs_task_definition" "echo" {
  family = "echo"

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 512
  memory = 1024

  execution_role_arn = aws_iam_role.ecs_echo_task_execution.arn
  task_role_arn      = aws_iam_role.echo.arn

  track_latest = true

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode(jsondecode(templatefile("./ecs_echo_task_definition.json", {
    image              = "${aws_ecr_repository.echo.repository_url}:v1"
    db_user            = "${aws_db_instance.main.master_user_secret[0].secret_arn}:username::"
    db_password        = "${aws_db_instance.main.master_user_secret[0].secret_arn}:password::"
    db_host            = aws_db_instance.main.address
    db_port            = "3306"
    db_name            = aws_db_instance.main.db_name
    log_group_name     = aws_cloudwatch_log_group.echo.name
    execution_role_arn = aws_iam_role.ecs_echo_task_execution.arn
    task_role_arn      = aws_iam_role.echo.arn
  })).containerDefinitions)

  #  container_definitions = jsonencode([
  #    {
  #      name      = "echo"
  #      image     = "${aws_ecr_repository.echo.repository_url}:v1"
  #      essential = true
  #      secrets = [
  #        {
  #          name      = "DB_USER"
  #          valueFrom = "${aws_db_instance.main.master_user_secret[0].secret_arn}:username::"
  #        },
  #        {
  #          name      = "DB_PASSWORD"
  #          valueFrom = "${aws_db_instance.main.master_user_secret[0].secret_arn}:password::"
  #        },
  #      ]
  #      environment = [
  #        {
  #          name  = "DB_HOST"
  #          value = aws_db_instance.main.address
  #        },
  #        {
  #          name  = "DB_PORT"
  #          value = "3306"
  #        },
  #        {
  #          name  = "DB_NAME"
  #          value = aws_db_instance.main.db_name
  #        },
  #      ]
  #      portMappings = [
  #        {
  #          name          = "http"
  #          protocol      = "tcp"
  #          appProtocol   = "http"
  #          containerPort = 1323
  #          hostPort      = 1323
  #        }
  #      ]
  #      logConfiguration = {
  #        logDriver = "awslogs"
  #        options = {
  #          "awslogs-create-group"  = "true"
  #          "awslogs-group"         = "${aws_cloudwatch_log_group.echo.name}"
  #          "awslogs-region"        = "ap-northeast-1"
  #          "awslogs-stream-prefix" = "ecs"
  #        }
  #      }
  #    }
  #  ])
}


resource "aws_ecs_cluster" "echo" {
  name = "echo"

}

resource "aws_ecs_service" "echo" {
  name             = "echo"
  cluster          = aws_ecs_cluster.echo.id
  task_definition  = aws_ecs_task_definition.echo.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = [aws_subnet.echo_1a.id, aws_subnet.echo_1c.id]
    security_groups  = [aws_security_group.echo.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.echo_1.arn
    container_name   = "echo"
    container_port   = 1323
  }

  lifecycle {
    ignore_changes = [desired_count, platform_version, load_balancer, task_definition]
  }
}
