require "env_enforcer/version"
require 'yaml'
require 'pry'

class MissingEnvKey < StandardError; end

module EnvEnforcer
  class << self
    def call
      raise MissingEnvKey, error_message if missing_keys.size > 0
    end

    private def error_message
      "Missing #{missing_keys.size} ENV key(s): #{missing_keys.join(',')}"
    end

    private def config_file
      @config_file ||= YAML.load_file('.env_enforcer.yml')
    end

    private def defined_keys
      ENV.keys.map(&:to_s)
    end

    private def default_keys
      config_file['default'] || []
    end

    private def environment_keys
      config_file[ENV['RAILS_ENV']] || []
    end

    private def required_keys
      (default_keys + environment_keys).compact
    end

    private def missing_keys
      missing_keys = (required_keys - defined_keys)
    end
  end
end
