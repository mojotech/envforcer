require "env_enforcer/version"
require 'yaml'
require 'pry'

module EnvEnforcer
  def self.call
    defined_keys = ENV.keys
    default_keys = YAML.load_file('.env_enforcer.yml')['default']
  end
end
