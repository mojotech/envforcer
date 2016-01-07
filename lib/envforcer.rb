require 'envforcer/version'
require 'yaml'
require 'rails'

class MissingEnvKey < StandardError; end

module EnvEnforcer
  class << self
    def call(env = ENV)
      @env = env
      # handle missing config file
      fail MissingEnvKey, error_message if missing_keys.size > 0
    end

    private

    def error_message
      "Missing #{missing_keys.size} ENV key(s): #{missing_keys.join(',')}"
    end

    def required_keys
      path = root.join('.envforcer.yml')

      @required_keys ||=
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
      @env.keys.map(&:to_s)
    end

    def missing_keys
      required_keys - defined_keys
    end
  end

  class Railtie < ::Rails::Railtie
    config.after_initialize { EnvEnforcer.call }
  end
end
