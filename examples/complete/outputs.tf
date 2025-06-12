output "json_alarm_arns" {
  description = "Map of alarm names to their ARNs (JSON configuration)"
  value       = module.cloudwatch_alarms_json.alarm_arns
}

output "direct_alarm_arns" {
  description = "Map of alarm names to their ARNs (direct configuration)"
  value       = module.cloudwatch_alarms_direct.alarm_arns
} 