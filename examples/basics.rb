$LOAD_PATH.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'google_books'

results = GoogleBooks::API.search('ruby')

# Get the total results (for the search, not the books returned)
puts "Total results for the term 'ruby': #{results.total_results}"

# Iterate through the books
for book in results
  puts "\"#{book.title}\" by #{book.authors.join(', ')}"
end

puts '-'*80

# Want more than ten books at a time? Use the :count option
results = GoogleBooks::API.search('ruby', :count => 20)
puts "#{results.count} results returned instead of default 10"

puts '-'*80

# Implement paging...
results = GoogleBooks::API.search('ruby', :count => 5, :page => 1)
puts '* Page 1 ***********************************************'
for book in results
  puts "\"#{book.title}\" by #{book.authors.join(', ')}"
end
results = GoogleBooks::API.search('ruby', :count => 5, :page => 2)
puts '* Page 2 ***********************************************'
for book in results
  puts "\"#{book.title}\" by #{book.authors.join(', ')}"
end