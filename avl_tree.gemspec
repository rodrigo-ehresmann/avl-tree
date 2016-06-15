# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'avl_tree/version'

Gem::Specification.new do |spec|
  spec.name          = "avl_tree"
  spec.version       = AvlTree::VERSION
  spec.authors       = ["Rodrigo Walter Ehresmann"]
  spec.email         = ["igoehresmann@gmail.com"]

  spec.summary       = %q{AVL tree implementation.}
  spec.homepage      = "https://github.com/rodrigo-ehresmann/avl-tree/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
