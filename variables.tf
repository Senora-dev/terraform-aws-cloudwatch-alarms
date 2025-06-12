variable "create_alarms" {
  description = "Controls whether CloudWatch alarms should be created"
  type        = bool
  default     = true
}

variable "alarms_json_path" {
  description = "Path to a JSON file containing alarm configurations. If provided, this will override the alarms variable."
  type        = string
  default     = null
}

variable "alarms" {
  description = "Map of alarm configurations. Will be ignored if alarms_json_path is provided."
  type = map(object({
    alarm_name          = string
    alarm_description   = optional(string)
    comparison_operator = string
    evaluation_periods  = number
    threshold          = number
    period             = optional(number, 300)
    unit               = optional(string)
    namespace          = string
    metric_name        = string
    statistic          = optional(string, "Average")
    dimensions         = optional(map(string), {})
    treat_missing_data = optional(string, "missing")
    actions_enabled    = optional(bool, true)
    alarm_actions      = optional(list(string), [])
    ok_actions         = optional(list(string), [])
    insufficient_data_actions = optional(list(string), [])
  }))
  default = {}
}

variable "metric_alarms" {
  description = "Map of metric alarms to create"
  type = map(object({
    alarm_description   = optional(string)
    comparison_operator = string
    evaluation_periods  = number
    threshold          = number
    unit               = optional(string)
    namespace          = string
    metric_name        = string
    period             = number
    statistic          = optional(string)
    extended_statistic = optional(string)
    actions_enabled    = optional(bool)
    alarm_actions      = optional(list(string))
    ok_actions         = optional(list(string))
    insufficient_data_actions = optional(list(string))
    metric_query       = optional(list(object({
      id          = string
      expression  = optional(string)
      label       = optional(string)
      return_data = optional(bool)
      metric      = optional(list(object({
        metric_name = string
        namespace   = string
        period     = number
        stat       = string
        unit       = optional(string)
        dimensions = optional(map(string))
      })))
    })))
    dimensions           = optional(map(string))
    treat_missing_data   = optional(string)
    datapoints_to_alarm  = optional(number)
    tags                 = optional(map(string))
  }))
  default = {}
}

variable "composite_alarms" {
  description = "Map of composite alarms to create"
  type = map(object({
    alarm_description   = optional(string)
    alarm_rule         = string
    actions_enabled    = optional(bool)
    alarm_actions      = optional(list(string))
    ok_actions         = optional(list(string))
    insufficient_data_actions = optional(list(string))
    tags               = optional(map(string))
  }))
  default = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
} 