module Envforcer
  class MissingEnvKey < StandardError
    def initialize(missing)
      super("Missing #{missing.size} ENV key(s): #{missing.join(',')}")
    end
  end

  class MissingConfigurationFile < StandardError
    def initialize(path)
      super(build_message(path))
    end

    def build_message(path)
      <<-MSG.gsub(/^\s+/, '')
        No Envforcer configuration file was found - #{path}
        Add your required ENV keys to #{path}:

        - REQUIRED_KEY1
        - REQUIRED_KEY2
        - REQUIRED_KEY3
      MSG
    end
  end
end
