provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

variable "name" {
  default = "example-parameter"
}
variable "parameter_name" {
  default = "myparameter/example"
}
variable "parameter_name_override" {
  default = "tf-basic-usage-parameter"
}
variable "tags" {
  default = {
    example = "true"
  }
}

module "parameter-override" {
  source = "../.."

  parameter_name_override = var.parameter_name_override
  tags                    = var.tags
  parameter_value         = "example"
}
output "parameter-override" {
  value     = module.parameter-override
  sensitive = true
}

module "parameter-random" {
  source = "../.."

  name            = var.name
  tags            = var.tags
  parameter_value = "example"
}
output "parameter-random" {
  value     = module.parameter-random
  sensitive = true
}
module "parameter" {
  source = "../.."

  name            = var.name
  parameter_name  = var.parameter_name
  tags            = var.tags
  parameter_value = "example"
}
output "parameter" {
  value     = module.parameter
  sensitive = true
}
