resource "aws_appautoscaling_target" "next" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.next.name}/${aws_ecs_service.next.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  role_arn           = aws_iam_role.autoscaling.arn
}

resource "aws_appautoscaling_policy" "next" {
  name               = "next"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.next.resource_id
  scalable_dimension = aws_appautoscaling_target.next.scalable_dimension
  service_namespace  = aws_appautoscaling_target.next.service_namespace

  target_tracking_scaling_policy_configuration {

    target_value = 70

    customized_metric_specification {

      metrics {
        id          = "cpu"
        return_data = true
        metric_stat {
          metric {
            namespace   = "AWS/ECS"
            metric_name = "CPUUtilization"
            dimensions {
              name  = "ServiceName"
              value = aws_ecs_service.next.name
            }
          }
          stat = "Average"
        }
      }

      metrics {
        id          = "memory"
        return_data = false
        metric_stat {
          metric {
            namespace   = "AWS/ECS"
            metric_name = "MemoryUtilization"
            dimensions {
              name  = "ServiceName"
              value = aws_ecs_service.next.name
            }
          }
          stat = "Average"
        }
      }

    }

  }

}

resource "aws_appautoscaling_policy" "next_memory" {
  name               = "next_memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.next.resource_id
  scalable_dimension = aws_appautoscaling_target.next.scalable_dimension
  service_namespace  = aws_appautoscaling_target.next.service_namespace

  target_tracking_scaling_policy_configuration {

    target_value = 70

    customized_metric_specification {

      metrics {
        id          = "memory"
        return_data = true
        metric_stat {
          metric {
            namespace   = "AWS/ECS"
            metric_name = "MemoryUtilization"
            dimensions {
              name  = "ServiceName"
              value = aws_ecs_service.next.name
            }
          }
          stat = "Average"
        }
      }

    }

  }

}