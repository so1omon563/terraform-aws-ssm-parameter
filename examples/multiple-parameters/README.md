# Multiple Parameters

Basic usage example passing in multiple parameters at once.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

module "parameter" {
  for_each = {
    "/myparameters/example1" = "value1"
    "/myparameters/example2" = "value2"
    "/myparameters/example3" = "value3"
  }
  source  = "so1omon563/ssm-parameter/aws"
  version = "2.0.0" # Replace with appropriate version

  name           = "example-parameter"
  parameter_name = each.key

  # Parameter value - sensitive values should not be placed in source control
  # Example value(s) placed here to show how calling the module can work.
  parameter_value = each.value
  tags = {
    example = "true"
  }
}
output "parameter" {
  value = module.parameter
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_parameter"></a> [parameter](#module\_parameter) | so1omon563/ssm-parameter/aws | 2.0.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_parameter"></a> [parameter](#output\_parameter) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
