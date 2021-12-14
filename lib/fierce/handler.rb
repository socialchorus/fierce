module Fierce
  module Handler
    def self.call(template, _)
      Fierce::StageManager.new(template).stage
    end 
  end
end