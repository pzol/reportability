# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reportability/version'

Gem::Specification.new do |gem|
  gem.name          = "reportability"
  gem.version       = Reportability::VERSION
  gem.authors       = ["Piotr Zolnierek"]
  gem.email         = ["pz@anixe.pl"]
  gem.description   = %q{Reportbility}
  gem.summary       = %q{Helps with reports}
  gem.homepage      = "http://github.com/pzol/reportability"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # gem.add_dependency 'activesupport'

  gem.add_development_dependency 'rspec', '>=2.9.0'
  gem.add_development_dependency 'turnip'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'guard-bundler'
  gem.add_development_dependency 'growl'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rb-fsevent', '~> 0.9.1'
end
