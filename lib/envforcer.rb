require 'envforcer/version'
require 'envforcer/environment'
require 'yaml'

module Envforcer
  def self.call
    Environment.enforce
  end
end
