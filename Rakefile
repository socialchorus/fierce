require "bundler/gem_tasks"

desc "uses rails dummy app to integration test gem"
task :integration_test do
  Dir.chdir(File.dirname(__FILE__) + "/integration_spec/dummy") do
    system('rspec')
  end
end

desc "runs local specs"
task :spec do
  system('rspec')
end

task :default => [:spec, :integration_test]
