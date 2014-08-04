$LOAD_PATH.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'google_books'

# Using the isbn keyword
books = GoogleBooks::API.search('isbn:9781118035580')
book = books.first

puts book.title
#=> "Hands - on ASP.NET AJAX Control Toolkit"
puts book.authors.first
#=> "Damien White" (Shameless plug)
puts book.covers[:thumbnail]
#=> "http://bks7.books.google.com/books?id=..."