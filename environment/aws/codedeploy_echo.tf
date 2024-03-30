resource "aws_codedeploy_app" "echo" {
  compute_platform = "ECS"
  name             = "echo"
}

resource "aws_codedeploy_deployment_group" "echo" {
  app_name               = aws_codedeploy_app.echo.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = "echo"
  service_role_arn       = aws_iam_role.ecs_deploy.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 1
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.echo.name
    service_name = aws_ecs_service.echo.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_lb_listener.alb_echo.arn]
      }

      target_group {
        name = aws_lb_target_group.echo_1.name
      }

      target_group {
        name = aws_lb_target_group.echo_2.name
      }
    }
  }
}

