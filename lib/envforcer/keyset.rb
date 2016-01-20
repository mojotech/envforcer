require 'set'

module Envforcer
  class MissingConfigurationFile < StandardError; end

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
      raise MissingConfigurationFile, <<-MSG
No Envforcer configuration file was found - #{path}
Add your required ENV keys to #{path}:

- REQUIRED_KEY1
- REQUIRED_KEY2
- REQUIRED_KEY3
MSG
    end
  end
end
