# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "google_books/version"

Gem::Specification.new do |s|
  s.name        = "google_books"
  s.version     = GoogleBooks::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Damien White"]
  s.email       = ["damien.white@visoftinc.com"]
  s.homepage    = "http://github.com/visoft/google_books"
  s.summary     = %q{A Ruby wrapper around the Google Books API}
  s.description = %q{A Ruby wrapper that allows you to query the Google Books API. This project was inspired by google-book, see the README for more information}
  
  s.add_dependency('httparty', '~> 0.8.1')
  s.add_dependency('hashie', '~> 1.1.0')
  
  s.add_development_dependency('rake', '~> 0.8.7')
  s.add_development_dependency('autotest', '~> 4.4.6')
  s.add_development_dependency('rspec', '~> 2.6.0')
  s.add_development_dependency('webmock', '~> 1.7.6')
  s.add_development_dependency('vcr', '~> 1.11.3')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end