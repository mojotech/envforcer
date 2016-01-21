class MissingEnvKey < StandardError; end

module Envforcer
  class Environment
    attr_accessor :source

    def self.enforce
      new.enforce
    end

    def initialize
      @source = ENV
    end

    def enforce
      # handle missing config file
      fail MissingEnvKey, error_message if missing_keys.size > 0
    end

    private

    def error_message
      "Missing #{missing_keys.size} ENV key(s): #{missing_keys.join(',')}"
    end

    def required_keys
      path = File.expand_path('.envforcer.yml')
      fail 'No .envforcer.yml file found.' unless File.exist?(path)

      @required_keys ||= YAML.load_file(path)
    end

    def defined_keys
      @source.keys.map(&:to_s)
    end

    def missing_keys
      required_keys - defined_keys
    end
  end
end
