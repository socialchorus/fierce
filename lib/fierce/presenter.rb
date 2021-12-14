module Fierce
  class Presenter
    attr_reader :view_model

    def initialize(view_model)
      @view_model = view_model
    end
  end
end