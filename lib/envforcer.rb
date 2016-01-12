require 'envforcer/version'
require 'envforcer/environment'
require 'yaml'

module Envforcer
  def self.enforce
    Environment.enforce
  end
end
