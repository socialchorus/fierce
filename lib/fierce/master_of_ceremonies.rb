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
      presenter_class = PresenterFinder.new(path).perform
      return unless presenter_class 
      if presenter_class.instance_method(:initialize) == 1
        presenter_class.new(view_model)
      else
        presenter_class.new
      end
    end

    def presenters
      collection = [
        DelegateGenerator::Controller.new(controller).generate,
        locals_presenter,
        context
      ]
      collection.unshift(custom_presenter) if custom_presenter
      collection
    end

    def locals_presenter
      Struct.new(*locals.keys.map(&:to_sym)).new(*locals.values)
    end

    def render
      # must switch to view class that understands partials better
      Mustache.render(content, view_model).html_safe
    end
  end
end