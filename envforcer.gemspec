# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envforcer/version'

Gem::Specification.new do |spec|
  spec.name          = 'envforcer'
  spec.version       = EnvEnforcer::VERSION
  spec.authors       = ['Adam Steel', 'Joel Hawksley']
  spec.email         = ['adamgsteel@gmail.com', 'joel@hawksley.org']

  spec.summary       = 'Enforce environment variable requirements.'
  spec.description   =
    'Storing configuration in the environment is one of the tenets of a ' \
    'twelve-factor app. However, problems arise when required environment ' \
    'variables aren\'t set.'
  spec.homepage      = 'https://www.github.com/mojotech/envforcer'

  spec.files         = `git ls-files app lib`.split('\n')
  spec.platform      = Gem::Platform::RUBY
  spec.require_paths = ['lib']

  spec.add_dependency 'rspec'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rails', '~> 4.2.1'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
end
