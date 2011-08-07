Google Books
============

Google Books is a Ruby wrapper to the [Google Books API](http://code.google.com/apis/books/docs/v1/getting_started.html)
The project was inspired by [google-book](https://github.com/papercavalier/google-book).  It is a nice wrapper, however the [Google Book Search Data API](http://code.google.com/apis/books/docs/gdata/developers_guide_protocol.html) "is deprecated as of May 26, 2011 and will be fully retired on December 1, 2011."

Usage
-----
The usage is similar to that of [google-book](https://github.com/papercavalier/google-book), but the semantics are a little different

    require 'google_books' # Or hey, add it to your Gemfile
  
    books = GoogleBooks::API.search('Douglas Crockford')
    book = books.first
    puts book.title
    #=> "JavaScript: The Good Parts"
    puts book.isbn
    #=> "9780596517748"
    puts book.covers[:thumbnail]
    #=> "http://bks8.books.google.com/books?id=..."

In addition to the query, the `GoogleBooks::API.search` method takes in a hash of 3 different options:


*   `count`: The number of results that you want returned, currently the default is 10 (set by Google)
*   `page`: The page of results that you want.  Combine this with `total_results` method of the `GoogleBooks::API::Response`, and implement paging in your application
*   `api_key`: For production apps, Google requires either [OAuth 2.0](http://code.google.com/apis/books/docs/v1/using.html#AboutAuthorization) or an [API key](http://code.google.com/apis/books/docs/v1/using.html#APIKey) to request public data. See the [API Documentation](http://code.google.com/apis/books/docs/v1/using.html#auth) for more information.

Queries
-------
Within your query that you pass to the search method, you can use special keywords as outlined in the [API Documentation](http://code.google.com/apis/books/docs/v1/using.html#q)

* `intitle`: Returns results where the text following this keyword is found in the title.
* `inauthor`: Returns results where the text following this keyword is found in the author.
* `inpublisher`: Returns results where the text following this keyword is found in the publisher.
* `subject`: Returns results where the text following this keyword is listed in the category list of the volume.
* `isbn`: Returns results where the text following this keyword is the ISBN number.

For example:
  
    # Get the book with the isbn of 9781118035580
    books = GoogleBooks::API.search('isbn:9781118035580')
    book = books.first

    puts book.title
    #=> "Hands - on ASP.NET AJAX Control Toolkit"
    puts book.authors.first
    #=> "Damien White" (Shameless plug)
    puts book.covers[:thumbnail]
    #=> "http://bks7.books.google.com/books?id=..."

Book Attributes
---------------
*   `title`: *String*

    This will append a subtitle if one exists, like "JavaScript: The Good Parts"

*   `authors`: *Array*
*   `publisher`: *String*
*   `published_date`: *Date*
*   `isbn`: *String*
*   `isbn_10`: *String*
*   `page_count`: *FixNum*
*   `categories`: *Array*
*   `description`: *String*
*   `average_rating`: *Float*
*   `ratings_count`: *FixNum*
*   `covers`: *Hash*

    The keys are `:thumbnail`, `:small`, `:medium`, `:large`, `:extra_large`

    Not all of the image URLs are guaranteed to return something.  Stick with thumbnail or small for the best results 

*   `preview_link`: *String*
*   `info_link`: *String*