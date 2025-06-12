# AWS CloudWatch Alarms Terraform Module

This Terraform module creates CloudWatch metric alarms with support for both direct configuration and JSON file-based configuration.

## Features

- Create multiple CloudWatch metric alarms
- Support for JSON file-based configuration
- Flexible alarm configuration with sensible defaults
- Support for all CloudWatch metric alarm parameters
- Tag support

## Usage

### Using JSON Configuration

```hcl
module "cloudwatch_alarms" {
  source = "path/to/module"

  alarms_json_path = "path/to/alarms.json"
  
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

Example `alarms.json`:
```json
{
  "high_cpu": {
    "alarm_name": "high-cpu-usage",
    "alarm_description": "This metric monitors EC2 CPU utilization",
    "comparison_operator": "GreaterThanThreshold",
    "evaluation_periods": 2,
    "threshold": 80,
    "period": 300,
    "namespace": "AWS/EC2",
    "metric_name": "CPUUtilization",
    "statistic": "Average",
    "dimensions": {
      "InstanceId": "i-1234567890abcdef0"
    },
    "alarm_actions": ["arn:aws:sns:us-west-2:123456789012:alert-topic"]
  }
}
```

### Using Direct Configuration

```hcl
module "cloudwatch_alarms" {
  source = "path/to/module"

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
  }

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarms_json_path | Path to a JSON file containing alarm configurations | `string` | `null` | no |
| alarms | Map of alarm configurations | `map(object(...))` | `{}` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| alarm_arns | Map of alarm names to their ARNs |
| alarm_ids | Map of alarm names to their IDs |

## Examples

* [Complete Example](examples/complete) - Shows both JSON and direct configuration methods

## Authors

Module is maintained by [Your Name]

## License

Apache 2 Licensed. See LICENSE for full details.

## Maintainers

This module is maintained by [Senora.dev](https://senora.dev). 