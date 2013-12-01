module Fierce
  class MasterOfCeremonies
    attr_reader    :content, :path, :locals, :controller, :context

    def initialize(content, path, locals, controller, context)
      @content =    content
      @path =       path
      @locals =     locals
      @controller = controller
      @context =    context
    end

    def view_model
      @view_model ||= ViewModel.new(*presenters)
    end

    def custom_presenter
      return unless presenter_class = PresenterFinder.new(path).perform

      if presenter_class.instance_method(:initialize) == 1
        presenter_class.new(view_model)
      else
        presenter_class.new
      end
    end

    def presenters
      collection = [
        DelegateGenerator::Controller.new(controller).generate,
        context
      ]
      collection.unshift(locals_presenter) if locals_presenter
      collection.unshift(custom_presenter) if custom_presenter
      collection
    end

    def locals_presenter
      return unless locals.size > 0
      Struct.new(*locals.keys.map(&:to_sym)).new(*locals.values)
    end

    def render
      Mustache.render(content, view_model).html_safe
    end
  end
end