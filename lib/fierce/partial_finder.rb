module Fierce
  class PartialFinder
    attr_reader :path, :name, :custom_presenter, :context

    def initialize(name, path, custom_presenter, context)
      @name = name
      @path = path
      @custom_presenter = custom_presenter
      @context = context
    end

    def presenter_partials
      return unless custom_presenter && custom_presenter.respond_to?(:partials)
      custom_presenter.partials.symbolize_keys
    end

    def presenter_path
      return unless presenter_partials
      presenter_partials[name]
    end

    def partial_path
      @partial_path ||= presenter_path || local_path
    end

    def local_path
      "#{dir(path)}/#{name}"
    end

    def dir(p)
      parts = p.split('/')
      dir = parts[0..parts.length-2]
      dir.join('/')
    end

    def mustache_partial
      context.lookup_context.find_template(partial_path, [], true, [], { handlers: [:mustache] })
    rescue
      false
    end

    def perform
      if template = mustache_partial
        template.source
      else
        context.render partial: partial_path
      end
    end
  end
end