# Parameters in SSM Parameter Store

Creates a Parameter in SSM Parameter Store that can be retrieved later.

This module can create a single parameter value by using the `parameter_name` and `parameter_value` variables. It can also create multiple parameters at once by using the `parameter_map` variable.

Please note that you must use one method or the other. If you provide a `parameter_map`, it will use it.

If using `parameter_map`, all other values "description, type, tier, etc" will be the same for all parameters created. If there is a need for differences in those values, call the module individually with the needed values.

An option for unique `description` values is to simply leave that variable blank. A default description with the name of the paramater will be created. This use case, along with others can be seen in the [examples](https://github.com/so1omon563/terraform-aws-ssm-parameter/tree/main/examples) directory.

### Populating the parameter

This module is designed to create one or more parameters by passing in the `parameter_name` and `parameter_value` OR the `parameter_map` variable at run-time. **DO NOT** place sensitive parameters in source control.

There are multiple options for passing in a sensitive parameter value.

The most common options include:

#### Use a .tfvars file

Use a `terraform.tfvars` file that contains the value of `parameter_value`.

Make sure that you have `terraform.tfvars` in your `.gitignore` so it doesn't accidentally get committed.

An example of the format for that is here:
```
# terraform.tfvars

parameter_value = "parameter_value"
```

#### Pass in input variable on command line

Pass in the value of `parameter_value`.

An example of `parameter_value` is here:

```
terraform apply -var="parameter_value=parameter_value"
```

Depending on how you are calling the module, this option may not always work as expected.

#### Pass in input variable using environment variables

You can also set your input variable as an environment variable in your shell prior to running Terraform.

An example of `parameter_value` is here:

```
$ export TF_VAR_parameter_value=parameter_value
$ terraform apply
```

### Ignoring changes

By default, this module will ignore changes to `var.parameter_value` after it is first created. If you wish to update the parameter with a new value, you can set the `ignore_changes` variable to `false`.

Setting this value to `false` will create a new resource that will change the parameter value any time it detects a change in the supplied value.

Examples for use can be found under the [examples](https://github.com/so1omon563/terraform-aws-ssm-parameter/tree/main/examples) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.44.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.parameter_ignore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.parameter_map](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.parameter_map_ignore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_id.parameter-random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_availability_zones.az](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_pattern"></a> [allowed\_pattern](#input\_allowed\_pattern) | A regular expression used to validate the parameter value. | `string` | `null` | no |
| <a name="input_data_type"></a> [data\_type](#input\_data\_type) | The data type for the parameter. Valid data types are `text`, `aws:ssm:integration`, and `aws:ec2:image`.<br><br>  For AMI format, see the [Native parameter support for Amazon Machine Image IDs](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-ec2-aliases.html).<br><br>  `aws:ssm:integration` data\_type parameters must be of the type `SecureString` and the name must start with the prefix `/d9d01087-4a3f-49e0-b0b4-d568d7826553/ssm/integrations/webhook/`. See [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/creating-webhook-integrations.html) for information on the usage of `aws:ssm:integration` parameters. | `string` | `"text"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the secret. If not provided, a default value based on `name` and `paramater_name` values will be used. | `string` | `null` | no |
| <a name="input_ignore_changes"></a> [ignore\_changes](#input\_ignore\_changes) | To ignore changes to the parameter or not. This allows for changing the parameter after initial creation if desired. | `bool` | `true` | no |
| <a name="input_kms_id"></a> [kms\_id](#input\_kms\_id) | The KMS key ID or ARN for encrypting a `SecureString`. If not provided, the parameter will be stored using the default, AWS managed key. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. If provided, resources will be named using this value as a prefix. | `string` | `null` | no |
| <a name="input_parameter_insecure_value"></a> [parameter\_insecure\_value](#input\_parameter\_insecure\_value) | Either this or `parameter_value` must be provided. The value of the parameter. **Use caution**: This value is never marked as sensitive in the Terraform plan output. This argument is not valid with a `type` of `SecureString`. Can not be used with the `parameter_map` variable. | `string` | `null` | no |
| <a name="input_parameter_map"></a> [parameter\_map](#input\_parameter\_map) | A map of `parameter_name` and `parameter_value` that can be used to populate multiple parameters at once. Please see information on `parameter_name` and `parameter_value` for acceptable values. Please note that this is not compatible with the `parameter_name_override`, or `parameter_insecure_value` variables. | `map(string)` | `null` | no |
| <a name="input_parameter_name"></a> [parameter\_name](#input\_parameter\_name) | The name of the parameter. Will be prepended with `/var.name/`. If no value is specified, then will use the format of `/var.name/random-hex`. Note that because this is prepended with `/var.name/`, no leading forward slash (/) is needed. Do **NOT** add a leading forward slash to the name. For additional requirements and constraints, see the [AWS SSM User Guide](https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html). | `string` | `null` | no |
| <a name="input_parameter_name_override"></a> [parameter\_name\_override](#input\_parameter\_name\_override) | Used if there is a need to specify a parameter name outside of the standardized nomenclature defined by the module. For example, if you have a specific naming pattern that falls outside of the defaults this module uses, or if importing a parameter that doesn't follow the module's naming formats. Can not be used if `parameter_map` is used. | `string` | `null` | no |
| <a name="input_parameter_value"></a> [parameter\_value](#input\_parameter\_value) | The value of the parameter. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the parameter. If not specified, will default to `Standard`. Valid tiers are `Standard`, `Advanced`, and `Intelligent-Tiering`. Downgrading an `Advanced` tier parameter to `Standard` will recreate the resource. For more information on parameter tiers, see the [AWS SSM Parameter tier comparison and guide](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html). | `string` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of the parameter. Valid types are `String`, `StringList` and `SecureString`. Defaults to `SecureString` to help ensure that parameters are encrypted. | `string` | `"SecureString"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_parameter"></a> [parameter](#output\_parameter) | Collection of outputs for the parameter - excluding the parameter value |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
