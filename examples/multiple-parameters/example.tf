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
  version = "1.1.0" # Replace with appropriate version

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
