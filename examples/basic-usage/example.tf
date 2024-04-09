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
