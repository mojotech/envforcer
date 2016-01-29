module Envforcer
  module GuardENV
    def ENV.undeclared_error_message(name)
      "You have attempted to access an undefined key: #{name}. " \
        "Define this key in #{ENVFORCER_CONFIG_FILE}."
    end

    class << ENV
      alias_method :original_brackets, :[]
    end

    def ENV.[](name)
      result = original_brackets(name)

      fail UndefinedEnvKey, undeclared_error_message(name) if result.nil?

      result
    end
  end
end
