require 'envforcer/environment'

module Envforcer
  class RailsEnvironment < Environment
    def config_file
      path = root.join('.envforcer.yml')

      @config_file ||=
        if File.exist?(path)
          YAML.load_file(path)
        else
          fail 'No .envforcer.yml file found.'
        end
    end

    def root
      Rails.root || Pathname.new(ENV['RAILS_ROOT'] || Dir.pwd)
    end
  end

  class Railtie < ::Rails::Railtie
    config.after_initialize { RailsEnvironment.new.enforce }
  end
end
