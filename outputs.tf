output "metric_alarm_arns" {
  description = "List of ARNs of the metric alarms"
  value       = { for k, v in aws_cloudwatch_metric_alarm.this : k => v.arn }
}

output "metric_alarm_ids" {
  description = "List of IDs of the metric alarms"
  value       = { for k, v in aws_cloudwatch_metric_alarm.this : k => v.id }
}

output "composite_alarm_arns" {
  description = "List of ARNs of the composite alarms"
  value       = { for k, v in aws_cloudwatch_composite_alarm.this : k => v.arn }
}

output "composite_alarm_ids" {
  description = "List of IDs of the composite alarms"
  value       = { for k, v in aws_cloudwatch_composite_alarm.this : k => v.id }
}

output "alarm_arns" {
  description = "Map of alarm names to their ARNs"
  value = merge(
    {
      for name, alarm in aws_cloudwatch_metric_alarm.this : name => alarm.arn
    },
    {
      for name, alarm in aws_cloudwatch_composite_alarm.this : name => alarm.arn
    }
  )
}

output "alarm_ids" {
  description = "Map of alarm names to their IDs"
  value = merge(
    {
      for name, alarm in aws_cloudwatch_metric_alarm.this : name => alarm.id
    },
    {
      for name, alarm in aws_cloudwatch_composite_alarm.this : name => alarm.id
    }
  )
} 