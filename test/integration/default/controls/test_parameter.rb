# frozen_string_literal: true

include_controls 'inspec-aws'
require './test/library/common'

tfstate = get_state

default_id = tfstate['outputs']['parameter']['value']['parameter']['/kitchen-default-example/myparameter/test-example']['name'].to_s

# For parameter_map tests
id_1 = tfstate['outputs']['parameter_map']['value']['parameter']['/kitchen-default-example-map/myparameters/example1']['name'].to_s
id_2 = tfstate['outputs']['parameter_map']['value']['parameter']['/kitchen-default-example-map/myparameters/example2']['name'].to_s
id_3 = tfstate['outputs']['parameter_map']['value']['parameter']['/kitchen-default-example-map/myparameters/example3']['name'].to_s

control 'default' do
  describe aws_ssm_parameter(name: default_id) do
    it { should exist }
  end

  describe aws_ssm_parameter(name: id_1) do
    it { should exist }
  end

  describe aws_ssm_parameter(name: id_2) do
    it { should exist }
  end

  describe aws_ssm_parameter(name: id_3) do
    it { should exist }
  end
end
