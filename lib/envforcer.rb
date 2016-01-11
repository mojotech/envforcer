require 'envforcer/version'
require 'envforcer/environment'
require 'yaml'

module Envforcer
  def self.call
    Environment.new.enforce
  end
end
