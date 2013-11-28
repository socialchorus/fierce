module Fierce
  module Handler
    def self.call(template)
      Fierce::StageManager.new(template).stage
    end 
  end
end