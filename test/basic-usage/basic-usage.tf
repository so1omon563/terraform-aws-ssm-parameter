terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
}

provider "aws" {
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

variable "name" {
  type    = string
  default = "example-parameter"
}
variable "parameter_name" {
  type    = string
  default = "myparameter/example"
}
variable "parameter_name_override" {
  type    = string
  default = "tf-basic-usage-parameter"
}
variable "tags" {
  type = map(string)
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
