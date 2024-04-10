# Generates a 2 byte random number that we will append to the parameter name. This avoids naming conflicts.
resource "random_id" "parameter-random" {
  for_each    = local.parameter_random
  byte_length = 2
}
