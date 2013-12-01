module Fierce
  class ViewModel
    def initialize(*presenters)
      @presenters = presenters
    end

    def method_missing(method, *args, &block)
      responder = @presenters.find do |delegate|
        delegate.respond_to?(method, include_private=true)
      end

      responder ? responder.send(method, *args, &block) : super
    end

    def respond_to?(method, include_private=false)
      super(method, include_private) || @presenters.any?{|p| p.respond_to?(method)}
    end

    def yield(area = :layout)
      content_for(area)
    end
  end
end