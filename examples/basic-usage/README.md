# Basic usage

Basic usage example.

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
  source         = "so1omon563/ssm-parameter/aws"
  version = "2.0.0" # Replace with appropriate version
  ignore_changes = false

  name           = "example-parameter"
  parameter_name = "myparameter/example"

  # Parameter value - sensitive values should not be placed in source control
  # Example value(s) placed here to show how calling the module can work.
  parameter_value = "See `Populating the parameter` in README.md"

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
