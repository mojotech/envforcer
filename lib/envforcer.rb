require 'envforcer/version'
require 'yaml'
require 'rails'

class MissingEnvKey < StandardError; end

module EnvEnforcer
  class << self
    def call
      # handle missing config file
      fail MissingEnvKey, error_message if missing_keys.size > 0
    end

    private

    def error_message
      "Missing #{missing_keys.size} ENV key(s): #{missing_keys.join(',')}"
    end

    def config_file
      path = root.join('.envforcer.yml')

      @config_file ||=
        if File.exist?(path)
          YAML.load_file(path)
        else
          fail 'No .envforcer.yml file found.'
        end
    end

    def root
      Rails.root || Pathname.new(ENV['RAILS_ROOT'] || Dir.pwd)
    end

    def defined_keys
      ENV.keys.map(&:to_s)
    end

    def default_keys
      config_file['default'] || []
    end

    def environment_keys
      config_file[ENV['RAILS_ENV']] || []
    end

    def required_keys
      (default_keys + environment_keys).compact
    end

    def missing_keys
      required_keys - defined_keys
    end
  end

  class Railtie < ::Rails::Railtie
    config.after_initialize { EnvEnforcer.call }
  end
end
