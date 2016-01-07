require 'spec_helper'

describe EnvEnforcer do
  describe "#call" do
    it 'remains silent given all the required keys are defined' do
      ruby_env = { REQUIRED_KEY: 'required' }

      expect { EnvEnforcer.call(ruby_env) }.not_to raise_error
    end

    it 'fails loudly if not all the required keys are defined' do
      ruby_env = {}

      expect { EnvEnforcer.call(ruby_env) }.to raise_error(
        MissingEnvKey, 'Missing 1 ENV key(s): REQUIRED_KEY'
      )
    end

    context 'when more keys are defined than required' do
      it 'ignores the unrequired keys' do
        ruby_env = {
          REQUIRED_KEY:   'my key',
          UNREQUIRED_KEY: 'undefined'
        }

        expect { EnvEnforcer.call(ruby_env) }.not_to raise_error
      end
    end
  end
end
