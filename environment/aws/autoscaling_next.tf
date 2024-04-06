resource "aws_appautoscaling_target" "next" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.next.name}/${aws_ecs_service.next.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "next" {
  name               = "next"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.next.resource_id
  scalable_dimension = aws_appautoscaling_target.next.scalable_dimension
  service_namespace  = aws_appautoscaling_target.next.service_namespace

  target_tracking_scaling_policy_configuration {

    target_value = 70

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
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

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }

}