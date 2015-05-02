$:.push File.expand_path('../lib', __FILE__)
require 'aurfy/version'

Gem::Specification.new do |s|
  s.name        = 'aurfy'
  s.version     = Aurfy::VERSION
  s.authors     = ['Masahiro Saito']
  s.email       = ['camelmasa@gmail.com']
  s.summary     = 'Ruby client for Aurfy'
  s.description = 'Ruby client for Aurfy'
  s.homepage    = 'https://github.com/camelmasa/aurfy'
  s.license     = 'MIT'

  s.files = `git ls-files`.split($/)
  s.require_paths = ['lib']

  s.add_runtime_dependency 'credit_card_reader', '~> 0.0.0'
  s.add_runtime_dependency 'faraday', '~> 0.9.0'
  s.add_development_dependency "pry", "~> 0.10.0"
  s.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'
end
