require 'httparty'
require 'hashie'

module GoogleBooks
  autoload :API, 'google_books/api'

  module API
    autoload :Response, 'google_books/api/response'
    autoload :Book,     'google_books/api/book'
  end
end
