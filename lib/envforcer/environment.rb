class MissingEnvKey < StandardError; end

module Envforcer
  class Environment
    attr_accessor :source

    def self.enforce
      new.enforce
    end

    def initialize(config_file = '.envforcer.yml')
      @config_file = ensure_file(config_file)
      @source = ENV
    end

    def enforce
      fail MissingEnvKey, error_message if missing_keys.size > 0
    end

    private

    def ensure_file(name)
      path = File.expand_path(name)
      fail "No #{name} file found." unless File.exist?(path)
      path
    end


    def error_message
      "Missing #{missing_keys.size} ENV key(s): #{missing_keys.join(',')}"
    end

    def required_keys
      @required_keys ||= YAML.load_file(@config_file)
    end

    def defined_keys
      @source.keys.map(&:to_s)
    end

    def missing_keys
      required_keys - defined_keys
    end
  end
end
