module Fierce
  class Renderer < ::Mustache
    attr_reader :mc

    def initialize(mc)
      @mc = mc
    end

    def partial(name)
      mc.partial(name)
    end
  end
end