require 'spec_helper'
require 'envforcer/keyset'

module Envforcer
  describe Keyset do
    describe '::from_env' do
      subject { described_class.from_env }

      it 'creates a instance using the keys from the environment' do
        env_keys = ENV.keys.to_a
        expect(subject.to_a).to eq env_keys
      end
    end

    describe '::from_config' do
      subject { described_class.from_config('spec/fixtures/test.yml') }

      it 'creates a instance using the keys from the environment' do
        test_keys = %w( FIRST_KEY SECOND_KEY )
        expect(subject.to_a).to eq test_keys
      end

      it 'raises an error with helpful text if the file cannot be found' do
        expected_msg = <<-MSG.gsub(/^\s+/, '')
          No Envforcer configuration file was found - /Users/micah/Code/envforcer/missing_file
          Add your required ENV keys to /Users/micah/Code/envforcer/missing_file:
          - REQUIRED_KEY1
          - REQUIRED_KEY2
          - REQUIRED_KEY3
        MSG

        expect { described_class.from_config('missing_file') }.to raise_error(
          MissingConfigurationFile, expected_msg
        )
      end
    end

    describe '#subset?' do
      subject { described_class.new([:foo, :bar, :baz]) }

      it 'returns true if the instance is a subset of the argument' do
        other = described_class.new([:foo, :bar, :baz, :bat])
        expect(subject.subset?(other)).to be true
      end

      it 'returns false if the instance has values not present in argument' do
        other = described_class.new([:foo, :bar, :bat])
        expect(subject.subset?(other)).to be false
      end
    end
  end
end
