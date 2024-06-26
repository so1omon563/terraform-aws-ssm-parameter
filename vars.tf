# This file is for variables that may be required for the module to run.

variable "name" {
  type        = string
  description = "Usually, a short, descriptive name of the environment without spaces. If provided, this will be used as the prefix for the parameter."
  default     = null
}

variable "parameter_map" {
  type        = map(string)
  description = "A map of `parameter_name` and `parameter_value` that can be used to populate multiple parameters at once. Please see information on `parameter_name` and `parameter_value` for acceptable values. Please note that this is not compatible with the `parameter_name_override`, or `parameter_insecure_value` variables."
  default     = null
}

variable "parameter_name" {
  type        = string
  description = "The name of the parameter. Will be prepended with `/var.name/`. If no value is specified, then will use the format of `/var.name/random-hex`. Note that because this is prepended with `/var.name/`, no leading forward slash (/) is needed. Do **NOT** add a leading forward slash to the name. For additional requirements and constraints, see the [AWS SSM User Guide](https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html)."
  default     = null
}

variable "parameter_name_override" {
  type        = string
  description = "Used if there is a need to specify a parameter name outside of the standardized nomenclature defined by the module. For example, if you have a specific naming pattern that falls outside of the defaults this module uses, or if importing a parameter that doesn't follow the module's naming formats. Can not be used if `parameter_map` is used."
  default     = null
}
variable "parameter_value" {
  type        = string
  description = "The value of the parameter."
  default     = null
}

variable "parameter_insecure_value" {
  type        = string
  description = "Either this or `parameter_value` must be provided. The value of the parameter. **Use caution**: This value is never marked as sensitive in the Terraform plan output. This argument is not valid with a `type` of `SecureString`. Can not be used with the `parameter_map` variable."
  default     = null
}

variable "allowed_pattern" {
  description = "A regular expression used to validate the parameter value."
  type        = string
  default     = null
}

variable "data_type" {
  type        = string
  description = <<EOT
  The data type for the parameter. Valid data types are `text`, `aws:ssm:integration`, and `aws:ec2:image`.

  For AMI format, see the [Native parameter support for Amazon Machine Image IDs](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-ec2-aliases.html).

  `aws:ssm:integration` data_type parameters must be of the type `SecureString` and the name must start with the prefix `/d9d01087-4a3f-49e0-b0b4-d568d7826553/ssm/integrations/webhook/`. See [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/creating-webhook-integrations.html) for information on the usage of `aws:ssm:integration` parameters.

  EOT

  default = "text"

  validation {
    condition = contains([
      "text",
      "aws:ec2:image",
      "aws:ssm:integration"
    ], var.data_type)
    error_message = "Valid values are limited to (text,aws:ec2:image,aws:ssm:integration)."
  }
}

variable "description" {
  description = "Description of the secret. If not provided, a default value based on `name` and `paramater_name` values will be used."
  type        = string
  default     = null
}

variable "ignore_changes" {
  description = "To ignore changes to the parameter or not. This allows for changing the parameter after initial creation if desired."
  type        = bool
  default     = true
}

variable "kms_id" {
  description = "The KMS key ID or ARN for encrypting a `SecureString`. If not provided, the parameter will be stored using the default, AWS managed key."
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "tier" {
  type        = string
  description = "The tier of the parameter. If not specified, will default to `Standard`. Valid tiers are `Standard`, `Advanced`, and `Intelligent-Tiering`. Downgrading an `Advanced` tier parameter to `Standard` will recreate the resource. For more information on parameter tiers, see the [AWS SSM Parameter tier comparison and guide](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html)."
  default     = null

  validation {
    condition = var.tier != null ? contains([
      "Standard",
      "Advanced",
      "Intelligent-Tiering",
    ], var.tier) : var.tier == null
    error_message = "Valid values are limited to (Standard,Advanced,Intelligent-Tiering)."
  }
}

variable "type" {
  type        = string
  description = "The type of the parameter. Valid types are `String`, `StringList` and `SecureString`. Defaults to `SecureString` to help ensure that parameters are encrypted."
  # Defaulted to `SecureString` because we want to prefer secure values.
  default = "SecureString"

  validation {
    condition = contains([
      "String",
      "StringList",
      "SecureString",
    ], var.type)
    error_message = "Valid values are limited to (String,StringList,SecureString)."
  }
}
