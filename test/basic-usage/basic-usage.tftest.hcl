# Some basic unit testing to verify that selected outputs of the main module return expected results.
# In order to reduce testing cost, only items that can be verified via a `terraform plan` are being tested here.

run "verify_parameter_outputs_plan" {
  command = plan
  assert {
    condition     = module.parameter.parameter["tf-basic-usage-parameter"].tags_all.example == "true" && module.parameter.parameter["tf-basic-usage-parameter"].tags_all.environment == "dev" && module.parameter.parameter["tf-basic-usage-parameter"].tags_all.terraform == "true"
    error_message = "One or more tags did not match expected result."
  }
}
