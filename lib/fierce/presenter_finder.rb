module Fierce
  class PresenterFinder
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def file_path(base_path)
      "#{base_path}/#{path}.rb"
    end

    def found?
      Fierce.paths.any? do |base_path|
        File.exist?(file_path(base_path))
      end
    end

    def perform
      presenter_class if found?
    end

    def presenter_class      
      "::#{path.classify}".constantize
    end
  end
end