require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'date'

require 'google_books'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }