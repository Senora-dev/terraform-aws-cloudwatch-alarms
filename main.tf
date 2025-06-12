locals {
  # Read alarms from JSON file if provided, otherwise use the alarms variable
  json_content = var.alarms_json_path != null ? jsondecode(file(var.alarms_json_path)) : {}
  
  # Convert JSON content to match the alarms variable type
  json_alarms = var.alarms_json_path != null ? {
    for name, alarm in local.json_content : name => {
      alarm_name                 = alarm.alarm_name
      alarm_description         = try(alarm.alarm_description, null)
      comparison_operator       = alarm.comparison_operator
      evaluation_periods       = alarm.evaluation_periods
      threshold                = alarm.threshold
      period                   = try(alarm.period, 300)
      unit                     = try(alarm.unit, null)
      namespace                = alarm.namespace
      metric_name              = alarm.metric_name
      statistic                = try(alarm.statistic, "Average")
      dimensions               = try(alarm.dimensions, {})
      treat_missing_data       = try(alarm.treat_missing_data, "missing")
      actions_enabled          = try(alarm.actions_enabled, true)
      alarm_actions            = try(alarm.alarm_actions, [])
      ok_actions              = try(alarm.ok_actions, [])
      insufficient_data_actions = try(alarm.insufficient_data_actions, [])
    }
  } : {}

  # Use JSON alarms if provided, otherwise use direct configuration
  alarms_config = var.alarms_json_path != null ? local.json_alarms : var.alarms
}

resource "aws_cloudwatch_metric_alarm" "this" {
  for_each = local.alarms_config

  alarm_name          = each.value.alarm_name
  alarm_description   = each.value.alarm_description
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  threshold           = each.value.threshold
  period             = each.value.period
  unit               = each.value.unit
  namespace          = each.value.namespace
  metric_name        = each.value.metric_name
  statistic          = each.value.statistic
  dimensions         = each.value.dimensions
  treat_missing_data = each.value.treat_missing_data
  actions_enabled    = each.value.actions_enabled
  alarm_actions      = each.value.alarm_actions
  ok_actions         = each.value.ok_actions
  insufficient_data_actions = each.value.insufficient_data_actions

  tags = var.tags
}

resource "aws_cloudwatch_composite_alarm" "this" {
  for_each = { for k, v in var.composite_alarms : k => v if var.create_alarms }

  alarm_name        = each.key
  alarm_description = try(each.value.alarm_description, null)
  alarm_rule        = each.value.alarm_rule
  actions_enabled   = try(each.value.actions_enabled, true)

  alarm_actions             = try(each.value.alarm_actions, [])
  ok_actions               = try(each.value.ok_actions, [])
  insufficient_data_actions = try(each.value.insufficient_data_actions, [])

  tags = merge(var.tags, try(each.value.tags, {}))
} 