provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

variable "parameter_name_override" {
  default = "tf-basic-usage-parameter"
}
variable "tags" {
  default = {
    example = "true"
  }
}

module "parameter" {
  source = "../.."

  parameter_name_override  = var.parameter_name_override
  tags  = var.tags
  parameter_value = "example"
}
output "parameter" {
  value     = module.parameter
  sensitive = true
}
