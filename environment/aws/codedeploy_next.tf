resource "aws_codedeploy_app" "next" {
  compute_platform = "ECS"
  name             = "next"
}

resource "aws_codedeploy_deployment_group" "next" {
  app_name               = aws_codedeploy_app.next.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = "next"
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
    cluster_name = aws_ecs_cluster.next.name
    service_name = aws_ecs_service.next.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_lb_listener.alb_next.arn]
      }

      target_group {
        name = aws_lb_target_group.next_1.name
      }

      target_group {
        name = aws_lb_target_group.next_2.name
      }
    }
  }
}

