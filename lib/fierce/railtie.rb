module Fierce
  class Railtie < ::Rails::Railtie
    initializer 'fierce.autoload', :before => :set_autoload_paths do |app|
      Fierce.add_path (Rails.root.to_s + "/app/presenters") # default opinionation

      Fierce.paths.each do |path|
        app.config.autoload_paths << path
      end
    end
  end
end

ActionView::Template.register_template_handler :mustache, Fierce::Handler