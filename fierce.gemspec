# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fierce/version'

Gem::Specification.new do |spec|
  spec.name          = "fierce"
  spec.version       = Fierce::VERSION
  spec.authors       = ["Kane Baccigalupi"]
  spec.email         = ["developers@socialchorus.com"]
  spec.description   = %q{Fierce, opinionate view logic for Rails}
  spec.summary       = %q{Fierce, opinionate view logic for Rails}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mustache"
  spec.add_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rails'
end
