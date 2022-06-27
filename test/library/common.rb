# frozen_string_literal: true

require 'json'
require 'pathname'

# get_state
#
# Helper function
# Gets the terraform state as a json object. Will only work if following the standard set by this repository, in that the texts are located
# in the "integration" directory and named the same as their root_module_directory in the "fixtures" directory
def get_state
  path = Pathname(caller_locations.first.absolute_path)
  testname = Pathname(path.dirname).parent.basename
  state_file = "test/fixture/#{testname}/terraform.tfstate.d/kitchen-terraform-default-#{testname}/terraform.tfstate"
  JSON.parse(File.read(state_file))
end
