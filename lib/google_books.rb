lib =  File.dirname(__FILE__)

require 'cgi'
require 'httparty'
require 'hashie'

require "#{lib}/google_books/api"
require "#{lib}/google_books/api/response"
require "#{lib}/google_books/api/book"