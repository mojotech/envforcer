require 'envforcer/environment'

class Envforcer::Railtie < ::Rails::Railtie
  config.after_initialize { Envforcer.enforce }
end
