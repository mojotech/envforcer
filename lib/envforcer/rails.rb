require 'envforcer/environment'

module Envforcer
  class Railtie < ::Rails::Railtie
    config.after_initialize { Envforcer.enforce }
  end
end
