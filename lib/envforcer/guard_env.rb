module Envforcer
  module GuardENV
    class << self
      def call(required_keys)
        @required_keys = required_keys

        strip_undeclared
        override_bracket_accessor
      end

      private

      def strip_undeclared
        ENV.select! { |k, _v| @required_keys.include?(k) }
      end

      def def_undeclared_error_message
        def ENV.undeclared_error_message(name)
          "You have attempted to access an undefined key: #{name}. " \
            "Define this key in #{CONFIG_FILE}."
        end
      end

      def def_override_bracket_accessor
        def ENV.[](name)
          result = original_brackets(name)

          fail UndefinedEnvKey, undeclared_error_message(name) if result.nil?

          result
        end
      end

      def def_original_brackets
        class << ENV
          alias_method :original_brackets, :[]
        end
      end

      def override_bracket_accessor
        return if ENV.respond_to?(:original_brackets)

        def_original_brackets
        def_undeclared_error_message
        def_override_bracket_accessor
      end
    end
  end
end
