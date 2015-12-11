$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'envforcer'

module EnvEnforcerSpecDSL
  def GivenConstant
    let!(:_saved_constant_names) { Object.constants }

    before do
      yield
    end

    after do
      new_constants = Object.constants - _saved_constant_names

      new_constants.
        select { |e| Object.const_get(e) }.
        each { |e| Object.send :remove_const, e }
    end
  end
end

RSpec.configure do |config|
  config.extend EnvEnforcerSpecDSL
end

RSpec::Expectations.configuration.warn_about_potential_false_positives = false
