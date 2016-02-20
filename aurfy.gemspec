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

  s.add_dependency "activesupport", "~> 4.2"
  s.add_dependency 'credit_card_reader', '~> 0.0.4'
  s.add_dependency 'faraday', '~> 0.9.0'
  s.add_dependency "rack", "~> 1.6"
end
