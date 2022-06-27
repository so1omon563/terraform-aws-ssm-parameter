output "parameter" {
  value = merge(
    {
      for key, value in aws_ssm_parameter.parameter_ignore : key => value if !contains(["value"], key)
    },
    {
      for key, value in aws_ssm_parameter.parameter : key => value if !contains(["value"], key)
    },
    {
      for key, value in aws_ssm_parameter.parameter_map_ignore : key => value if !contains(["value"], key)
    },
    {
      for key, value in aws_ssm_parameter.parameter_map : key => value if !contains(["value"], key)
    }
  )
  description = "Collection of outputs for the parameter - excluding the parameter value"
}
