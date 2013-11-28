module Fierce
  class PresenterFinder
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def root
      Rails.root
    end

    def found
      @found = Fierce.paths.map do |p| 
        file_path = "#{p}/#{path}.rb"
        file_path if File.exist?(file_path)
      end.compact.first
    end

    def perform
      presenter_class if found
    end

    def class_path
      found.gsub(Rails.root, '').gsub(/\.rb$/, '')
    end

    def presenter_class
      require found
      class_path.classify.constantize
    end
  end
end