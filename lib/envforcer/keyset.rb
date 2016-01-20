require 'set'
require 'envforcer/errors'

module Envforcer
  class Keyset < Set
    DEFAULT_CONFIG_FILE = '.envforcer.yml'.freeze

    def self.from_env
      new(ENV.keys)
    end

    def self.from_config(filename = DEFAULT_CONFIG_FILE)
      path = File.expand_path(filename)
      keys = load_file(path)
      new(keys)
    end

    def self.load_file(path)
      YAML.load_file(path)
    rescue Errno::ENOENT
      raise MissingConfigurationFile.new(path)
    end
  end
end
