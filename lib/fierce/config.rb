module Fierce
  def self.add_path(*additional_paths)
    additional_paths.each do |path|
      paths << path.to_s
    end
  end

  def self.paths
    @paths ||= []
  end

  def self.clear_paths
    paths.clear
  end
end