module Presenters
  module Home
    class Show
      attr_reader :view_model

      def initialize(view_model)
        @view_model = view_model
      end

      def loop_count
        view_model.loop_it
      end

      def loops
        (1..loop_count).to_a.map{|n| Looplet.new(n) }
      end

      class Looplet < Struct.new(:n)
      end
    end
  end
end