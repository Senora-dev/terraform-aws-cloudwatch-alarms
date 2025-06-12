provider "aws" {
  region = "us-west-2"
}

# Example using JSON configuration
module "cloudwatch_alarms_json" {
  source = "../../"

  alarms_json_path = "${path.module}/alarms.json"
  
  tags = {
    Environment = "test"
    Project     = "example"
  }
}

# Example using direct configuration
module "cloudwatch_alarms_direct" {
  source = "../../"

  alarms = {
    high_cpu = {
      alarm_name          = "high-cpu-usage"
      alarm_description   = "This metric monitors EC2 CPU utilization"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 2
      threshold          = 80
      period            = 300
      namespace         = "AWS/EC2"
      metric_name       = "CPUUtilization"
      statistic         = "Average"
      dimensions = {
        InstanceId = "i-1234567890abcdef0"
      }
      alarm_actions    = ["arn:aws:sns:us-west-2:123456789012:alert-topic"]
    }
    
    low_memory = {
      alarm_name          = "low-memory-available"
      alarm_description   = "This metric monitors EC2 memory usage"
      comparison_operator = "LessThanThreshold"
      evaluation_periods  = 3
      threshold          = 10
      period            = 300
      namespace         = "System/Linux"
      metric_name       = "MemoryUtilization"
      statistic         = "Average"
      dimensions = {
        InstanceId = "i-1234567890abcdef0"
      }
      alarm_actions    = ["arn:aws:sns:us-west-2:123456789012:alert-topic"]
    }
  }

  tags = {
    Environment = "test"
    Project     = "example"
  }
} 