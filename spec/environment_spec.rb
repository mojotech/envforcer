require 'spec_helper'

module Envforcer
  describe Environment do
    describe '#enforce' do
      it 'remains silent given all the required keys are defined' do
        env = Set.new(['FOO'])
        config = Set.new(['FOO'])
        subject = Environment.new(env, config)

        expect { subject.enforce }.not_to raise_error
      end

      it 'fails loudly if not all the required keys are defined' do
        env = Set.new
        config = Set.new(['REQUIRED_KEY'])
        subject = Environment.new(env, config)

        expect { subject.enforce }.to raise_error(
          MissingEnvKey, 'Missing 1 ENV key(s): REQUIRED_KEY'
        )
      end

      context 'when more keys are defined than required' do
        it 'ignores the unrequired keys' do
          env = Set.new(%w( UNREQUIRED_KEY REQUIRED_KEY ))
          config = Set.new(['REQUIRED_KEY'])
          subject = Environment.new(env, config)

          expect { subject.enforce }.not_to raise_error
        end
      end
    end
  end
end
