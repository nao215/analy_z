# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'analy_z/version'

Gem::Specification.new do |spec|
  spec.name          = "analy_z"
  spec.version       = AnalyZ::VERSION
  spec.authors       = ["nao215"]
  spec.email         = ["xxxxxy.naoxxxxx@gmail.com"]
  spec.summary       = %q{Text Analyzer}
  spec.description   = %q{calcurate tf idf and hse(html semantic element) }
  spec.homepage      = ""

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "natto"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
