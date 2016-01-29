require 'envforcer/constants'
require 'envforcer/environment'
require 'envforcer/guard_env'
require 'envforcer/version'
require 'yaml'

module Envforcer
  def self.enforce
    Environment.enforce
  end
end
