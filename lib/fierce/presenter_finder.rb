module Fierce
  class PresenterFinder
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def root
      Rails.root.to_s
    end

    def file_path(base_path)
      "#{base_path}/#{path}.rb"
    end

    def found
      @found = Fierce.paths.map do |base_path|
        base_path if File.exist?(file_path(base_path))
      end.compact.first
    end

    def perform
      presenter_class if found
    end

    def path_to_classify
      found
        .gsub(root, '')
        .gsub('/app', '')
        .gsub(/\.rb$/, '') + "/#{path}"
    end

    def presenter_class
      require file_path(found)
      path_to_classify.classify.constantize
    end
  end
end