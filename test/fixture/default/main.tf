variable "name" {}

variable "tags" {}

variable "parameter_name" {}

variable "parameter_value" {}

variable "map_name" {}

variable "parameter_map" {}

provider "aws" {
  default_tags {
    tags = var.tags
  }
}

module "parameter" {
  source = "../../../"

  name            = var.name
  parameter_name  = var.parameter_name
  parameter_value = var.parameter_value
}
output "parameter" {
  value     = module.parameter
  sensitive = true
}

module "parameter_map" {
  source = "../../../"

  name          = var.map_name
  parameter_map = var.parameter_map
}
output "parameter_map" {
  value     = module.parameter_map
  sensitive = true
}
