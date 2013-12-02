module Fierce
  class MasterOfCeremonies
    attr_reader    :template, :path, :locals, :controller, :context

    def initialize(template, path, locals, controller, context)
      @template =   template
      @path =       path
      @locals =     locals
      @controller = controller
      @context =    context
    end

    def view_model
      @view_model ||= ViewModel.new(*presenters)
    end

    def custom_presenter
      return @custom_presenter if @custom_presenter
      return unless presenter_class = PresenterFinder.new(path).perform

      @custom_presenter = if presenter_class.instance_method(:initialize).arity == 1
        presenter_class.new(ViewModel.new(*base_presenters))
      else
        presenter_class.new
      end
    end

    def base_presenters
      collection = [
        DelegateGenerator::Controller.new(controller).generate,
        context
      ]
      collection.unshift(locals_presenter) if locals_presenter
      collection
    end

    def presenters
      collection = base_presenters
      collection.unshift(custom_presenter) if custom_presenter
      collection
    end

    def locals_presenter
      return unless locals.size > 0
      Struct.new(*locals.keys.map(&:to_sym)).new(*locals.values)
    end

    def render
      Renderer.new(self).render(template, view_model).html_safe
    end

    def partial(name)
      partial = PartialFinder.new(name, path, custom_presenter, context).perform
    end
  end
end