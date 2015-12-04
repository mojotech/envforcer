require 'spec_helper'

describe EnvEnforcer do
  context 'given all the required keys are defined' do
    GivenConstant do
      ENV = {
        REQUIRED_KEY: 'required',
      }
    end

    it 'works' do
      expect { EnvEnforcer.call }.not_to raise_error(MissingEnvKey)
    end
  end

  context 'given all the required keys are not defined' do
    GivenConstant do
      ENV = {}
    end

    it 'fails' do
      expect { EnvEnforcer.call }.to raise_error(MissingEnvKey, "Missing 1 ENV key(s): REQUIRED_KEY")
    end
  end

  context 'more keys are defined than required' do
    GivenConstant do
      ENV = {
        REQUIRED_KEY: 'my key',
        UNREQUIRED_KEY: 'undefined'
      }
    end

    it 'ignores the unrequired keys' do
      expect { EnvEnforcer.call }.not_to raise_error(MissingEnvKey)
    end
  end

  context 'given a rails production environment' do
    GivenConstant do
      ENV = {
        RAILS_ENV: 'production',
        KEY_ONE: 'my key'
      }
    end

    it 'checks for the production key' do
      expect { EnvEnforcer.call }.to raise_error(MissingEnvKey)
    end
  end
end
