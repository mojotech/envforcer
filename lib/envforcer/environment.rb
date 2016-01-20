class MissingEnvKey < StandardError; end

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
      fail MissingEnvKey, error_message unless all_required_keys_present?
    end

    private

    def all_required_keys_present?
      @required.subset?(@env)
    end

    def missing_keys
      @required.difference(@env).to_a
    end

    def error_message
      "Missing #{missing_keys.size} ENV key(s): #{missing_keys.join(',')}"
    end
  end
end
