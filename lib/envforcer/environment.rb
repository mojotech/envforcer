require 'envforcer/errors'

module Envforcer
  class Environment
    def self.enforce
      new.enforce
    end

    def initialize(env = Keyset.from_env, required = Keyset.from_config)
      @env      = env
      @required = required
    end

    def enforce
      fail MissingEnvKey.new(missing_keys) unless all_required_keys_present?
    end

    private

    def all_required_keys_present?
      @required.subset?(@env)
    end

    def missing_keys
      @required.difference(@env).to_a
    end
  end
end
