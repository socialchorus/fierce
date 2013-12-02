module Fierce
  class PresenterFinder
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def file_path(base_path)
      "#{base_path}/#{path}.rb"
    end

    def found_base_path
      @found = Fierce.paths.map do |base_path|
        base_path if File.exist?(file_path(base_path))
      end.compact.first
    end

    def perform
      presenter_class if found_base_path
    end

    def path_to_classify
      top_module = found_base_path.split('/').last
      "#{top_module}/#{path}"
    end

    def presenter_class      
      require file_path(found_base_path)
      path_to_classify.classify.constantize
    end
  end
end