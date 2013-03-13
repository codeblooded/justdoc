# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'justdoc/version'

Gem::Specification.new do |spec|
  spec.name          = "justdoc"
  spec.version       = Justdoc::VERSION
  spec.authors       = ["Benjamin Reed"]
  spec.email         = ["benvreed@gmail.com"]
  spec.description   = %q{Simple documentation generator that does the hard work, keeps comments readable, and does not require large configuration files.}
  spec.summary       = %q{Simple, Lightweight Documentation Generator built to track Git.}
  spec.homepage      = "https://github.com/codeblooded/justdoc"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.required_ruby_version      = '>= 2.0.0'
  spec.required_rubygems_version  = '>= 1.8.11'

  spec.add_dependency 'rugged', '~> 0.16.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
