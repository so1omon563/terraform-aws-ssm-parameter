# This file is for variables that may be required for the module to run.

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "parameter_map" {
  type        = map(string)
  description = "A map of `parameter_name` and `parameter_value` that can be used to populate multiple parameters at once. Please see information on `parameter_name` and `parameter_value` for acceptable values."
  default     = null
}

variable "parameter_name" {
  type        = string
  description = "The name of the parameter. Will be prepended with `/var.name/`. If no value is specified, then will use the format of `/var.name/random-hex`. Note that because this is prepended with `/var.name/`, no leading forward slash (/) is needed. Do **NOT** add a leading forward slash to the name. For additional requirements and constraints, see the [AWS SSM User Guide](https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html)."
  default     = null
}

variable "parameter_value" {
  type        = string
  description = "The value of the parameter."
  default     = null
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

variable "description" {
  description = "Description of the secret. If not provided, a default value based on `name` and `paramater_name` values will be used."
  type        = string
  default     = null
}

variable "tier" {
  type        = string
  description = "The tier of the parameter. If not specified, will default to `Standard`. Valid tiers are `Standard`, `Advanced`, and `Intelligent-Tiering`. For more information on parameter tiers, see the [AWS SSM Parameter tier comparison and guide](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html)."
  default     = "Standard"

  validation {
    condition = contains([
      "Standard",
      "Advanced",
      "Intelligent-Tiering",
    ], var.tier)
    error_message = "Valid values are limited to (Standard,Advanced,Intelligent-Tiering)."
  }
}

variable "kms_arn" {
  description = "The KMS key id or arn for encrypting a SecureString. If not provided, the parameter will be stored using the default key."
  type        = string
  default     = null
}

variable "allowed_pattern" {
  description = "A regular expression used to validate the parameter value."
  type        = string
  default     = null
}

variable "data_type" {
  description = "The data_type of the parameter. Valid values: `text` and `aws:ec2:image` for AMI format, see the [Native parameter support for Amazon Machine Image IDs](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-ec2-aliases.html)."
  type        = string
  default     = null

  validation {
    condition = var.data_type != null ? contains([
      "text",
      "aws:ec2:image",
    ], var.data_type) : var.data_type == null
    error_message = "Valid values are limited to (text,aws:ec2:image)."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "ignore_changes" {
  description = "To ignore changes to the parameter or not. This allows for changing the parameter after initial creation if desired."
  type        = bool
  default     = true
}
