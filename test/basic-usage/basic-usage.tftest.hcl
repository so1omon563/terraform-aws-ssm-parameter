# Some basic unit testing to verify that selected outputs of the main module return expected results.
# In order to reduce testing cost, only items that can be verified via a `terraform plan` are being tested here.

run "verify_parameter_outputs_plan" {
  command = plan
  assert {
    condition     = module.parameter-override.parameter["parameter"].name == "tf-basic-usage-parameter"
    error_message = "Name did not match expected result."
  }
  assert {
    condition     = module.parameter-override.parameter["parameter"].tags_all.example == "true" && module.parameter-override.parameter["parameter"].tags_all.environment == "dev" && module.parameter-override.parameter["parameter"].tags_all.terraform == "true"
    error_message = "One or more tags did not match expected result."
  }

  assert {
    condition     = module.parameter.parameter["parameter"].name == "/example-parameter/myparameter/example"
    error_message = "Name did not match expected result."
  }
  assert {
    condition     = module.parameter.parameter["parameter"].tags_all.example == "true" && module.parameter.parameter["parameter"].tags_all.environment == "dev" && module.parameter.parameter["parameter"].tags_all.terraform == "true"
    error_message = "One or more tags did not match expected result."
  }

  assert {
    condition     = module.parameter-random.parameter["parameter"].tags_all.example == "true" && module.parameter-random.parameter["parameter"].tags_all.environment == "dev" && module.parameter-random.parameter["parameter"].tags_all.terraform == "true"
    error_message = "One or more tags did not match expected result."
  }
}
