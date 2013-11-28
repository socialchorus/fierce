module Fierce
  class StageManager
    attr_reader :template

    def initialize(template)
      @template = template
    end

    delegate :virtual_path, :source,
      to: :template

    def stage
      <<-RUBY
        content = #{source.inspect}
        path = #{virtual_path.inspect}

        Fierce::MasterOfCeremonies.new(
          content, path, local_assigns, controller, self
        ).render
      RUBY
    end
  end
end