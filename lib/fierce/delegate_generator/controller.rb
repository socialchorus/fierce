module Fierce
  module DelegateGenerator
    class Controller
      attr_reader :controller

      def initialize(controller)
        @controller = controller
      end

      def generate
        delegate_class.new(*ivars)
      end

      def delegate_class
        Struct.new(*accessor_names)
      end

      def accessor_names
        ivar_names.map {|name| name.to_s.gsub('@', '').to_sym }
      end

      def ivar_names
        controller.instance_variables - 
          controller.protected_instance_variables -
          excluded_ivars
      end

      def excluded_ivars
        [:@template]
      end

      def ivars
        ivar_names.map { |name|
          controller.instance_variable_get(name)
        }
      end
    end
  end
end