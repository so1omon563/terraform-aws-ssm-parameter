name            = "kitchen-default-example"
parameter_name  = "myparameter/test-example"
parameter_value = "test parameter"

map_name = "kitchen-default-example-map"

parameter_map = {
  "myparameters/example1" = "value1"
  "myparameters/example2" = "value2"
  "myparameters/example3" = "value3"
}

tags = {
  environment = "dev"
  terraform   = "true"
  kitchen     = "true"
}
