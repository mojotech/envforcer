require 'spec_helper'

module Envforcer
  describe Environment do
    describe '#enforce' do
      subject { Environment.new('spec/fixtures/test_config.yml') }

      it 'remains silent given all the required keys are defined' do
        subject.source = { REQUIRED_KEY: 'required' }
        expect { subject.enforce }.not_to raise_error
      end

      it 'fails loudly if not all the required keys are defined' do
        subject.source = {}
        expect { subject.enforce }.to raise_error(
          MissingEnvKey, 'Missing 1 ENV key(s): REQUIRED_KEY'
        )
      end

      context 'when more keys are defined than required' do
        it 'ignores the unrequired keys' do
          subject.source = {
            REQUIRED_KEY:   'my key',
            UNREQUIRED_KEY: 'undefined'
          }

          expect { subject.enforce }.not_to raise_error
        end
      end
    end
  end
end
