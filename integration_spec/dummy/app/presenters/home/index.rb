module Presenters
  module Home
    class Index
      def from_the_presenter
        'Hello from the presenter'
      end

      def partials
        {
          far_away: '/layouts/far_away'
        }
      end
    end
  end
end