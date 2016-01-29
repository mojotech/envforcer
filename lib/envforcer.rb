require 'envforcer/version'
require 'envforcer/environment'
require 'envforcer/guard_env'
require 'yaml'

module Envforcer
  def self.enforce
    Environment.enforce
  end
end
