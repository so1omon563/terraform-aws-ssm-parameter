resource "aws_ssm_parameter" "parameter_ignore" {
  #checkov:skip=CKV2_AWS_34: "AWS SSM Parameter should be Encrypted" - Default value is encrypted. Since this is a re-usable module, this needs to be able to be overridden.
  for_each        = local.parameter_ignore
  name            = local.parameter_name
  type            = var.type
  value           = var.parameter_value
  description     = var.description == null ? "Parameter for ${local.parameter_name}" : var.description
  tier            = var.tier
  key_id          = var.kms_arn
  allowed_pattern = var.allowed_pattern
  data_type       = var.data_type
  tags            = merge(tomap({ "IgnoreValueChanges" = "true" }), local.tags)

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "parameter" {
  #checkov:skip=CKV2_AWS_34: "AWS SSM Parameter should be Encrypted" - Default value is encrypted. Since this is a re-usable module, this needs to be able to be overridden.
  for_each        = local.parameter
  name            = local.parameter_name
  type            = var.type
  value           = var.parameter_value
  description     = var.description == null ? "Parameter for ${local.parameter_name}" : var.description
  tier            = var.tier
  key_id          = var.kms_arn
  allowed_pattern = var.allowed_pattern
  data_type       = var.data_type
  tags            = merge(tomap({ "IgnoreValueChanges" = "false" }), local.tags)
}

resource "aws_ssm_parameter" "parameter_map_ignore" {
  #checkov:skip=CKV2_AWS_34: "AWS SSM Parameter should be Encrypted" - Default value is encrypted. Since this is a re-usable module, this needs to be able to be overridden.
  for_each        = local.parameter_ignore_map
  name            = each.key
  type            = var.type
  value           = each.value
  description     = var.description == null ? "Parameter for ${each.key}" : var.description
  tier            = var.tier
  key_id          = var.kms_arn
  allowed_pattern = var.allowed_pattern
  data_type       = var.data_type
  tags            = merge(tomap({ "IgnoreValueChanges" = "true" }), local.tags)

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "parameter_map" {
  #checkov:skip=CKV2_AWS_34: "AWS SSM Parameter should be Encrypted" - Default value is encrypted. Since this is a re-usable module, this needs to be able to be overridden.
  for_each        = local.parameter_map
  name            = each.key
  type            = var.type
  value           = each.value
  description     = var.description == null ? "Parameter for ${each.key}" : var.description
  tier            = var.tier
  key_id          = var.kms_arn
  allowed_pattern = var.allowed_pattern
  data_type       = var.data_type
  tags            = merge(tomap({ "IgnoreValueChanges" = "false" }), local.tags)
}
