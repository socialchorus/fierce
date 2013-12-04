module Fierce
  class Presenter
    attr_reader :view_model

    def initialize(view_model)
      @view_model = view_model
    end

    def self.delegations(*args)
      args.push({to: :view_model})
      delegate *args
    end
  end
end