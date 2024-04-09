# This file is for local values that may be required for the module to run.

locals {
  region         = data.aws_region.current.id
  account_id     = data.aws_caller_identity.current.account_id
  tags           = var.tags
  parameter_name = var.parameter_name_override != null ? var.parameter_name_override : var.parameter_name == null ? format("/%s/%s", var.name, random_id.parameter-random.hex) : format("/%s/%s", var.name, var.parameter_name)
  # Setting these 2 values to avoid mixing count and for_each. It also helps better name the outputs. The value is irrelavent. We only care about the key.
  parameter_ignore = var.ignore_changes == true && var.parameter_map == null ? { (local.parameter_name) = "ignore" } : {}
  parameter        = var.ignore_changes == false && var.parameter_map == null ? { (local.parameter_name) = "noignore" } : {}
  # Setting these 2 values to provide a map with the full names for the parameter_map resources.
  parameter_ignore_map = var.ignore_changes == true && var.parameter_map != null ? merge({ for key, value in var.parameter_map : format("/%s/%s", var.name, key) => value }) : {}
  parameter_map        = var.ignore_changes == false && var.parameter_map != null ? merge({ for key, value in var.parameter_map : format("/%s/%s", var.name, key) => value }) : {}
}
