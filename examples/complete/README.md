# Complete CloudWatch Alarms Example

This example demonstrates both methods of configuring CloudWatch alarms using this module:
1. Using a JSON configuration file
2. Using direct Terraform configuration

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

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

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| json_alarm_arns | Map of alarm names to their ARNs (JSON configuration) |
| direct_alarm_arns | Map of alarm names to their ARNs (direct configuration) |

## Additional Notes

This example creates alarms for:
- High CPU utilization (> 80% for 2 periods)
- Low memory availability (< 10% for 3 periods)

The alarms are configured to send notifications to an SNS topic (which you would need to create separately). 