module Presenters
  module Layouts
    class Application
      attr_reader :view_model

      def initialize(view_model)
        @view_model = view_model
      end

      def stylesheets
        view_model.stylesheet_link_tag('application', media: 'all')
      end

      def javascripts
        view_model.javascript_include_tag('application')
      end
    end
  end
end