# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'functional_operations/version'

Gem::Specification.new do |spec|
  spec.name          = "functional_operations"
  spec.version       = FunctionalOperations::VERSION
  spec.authors       = ["Juan Ibiapina", "Marcelo Boeira"]
  spec.email         = ["juanibiapina@gmail.com" "me@marceloboeira.com"]

  spec.summary       = %q{Simple functional operations for your business logic}
  spec.homepage      = "https://github.com/juanibiapina/functional_operations"
  spec.license       = "MIT"

  spec.files         = %w(CODE_OF_CONDUCT.md LICENSE.txt README.md Rakefile) + Dir["{spec,lib}/**/*.{rb,RB}"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
end
