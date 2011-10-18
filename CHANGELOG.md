CHANGELOG
=========

v0.1.0
------
This is the initial version of google_books

*   `GoogleBooks::API` contains the search method which takes in 3 different options `count`, `page`, and `api_key`
*   The `GoogleBooks::API.search` method returns a `GoogleBooks::API::Response`

    *   Iterate through the Response and each result is a `GoogleBooks::API::Book`
    *   Use the `total_results` method of the Response to get the total number of results that were found for your query (but not the count of books returned).  This can be used for paging.
*   The `GoogleBooks::API::Book` model handles the following attributes:
  *   `title` - *String*
  *   `authors` - *Array*
  *   `publisher` - *String*
  *   `published_date` - *Date*
  *   `isbn` - *String*
  *   `isbn_10` - *String*
  *   `page_count` - *FixNum*
  *   `categories` - *Array*
  *   `description` - *String*
  *   `average_rating` - *Float*
  *   `ratings_count` - *FixNum*
  *   `covers` - *Hash*, with the following keys:
        * `:thumbnail`
        * `:small`
        * `:medium`
        * `:large`
        * `:extra_large`
  *   `preview_link` - *String*
  *   `info_link` - *String*

v0.2.0
------
*   New Features
      *   Standardized publisher names in a similar fashion to the [google-book gem](https://rubygems.org/gems/google-book)
*   Bug Fixes
      *   The publishedDate field in the Google Books API are strings in the format of YYYY-MM-DD. Sometimes it's just YYYY and other times it's YYYY-MM.  Previously the `published_date` attribute was a Date type, now it is a string and you can convert the date however you want in your applications.
v0.2.1
------
*   Bug Fixes
      *   Removed call to blank? in the `normalize_publisher` method of the Book class
*   Other
      *   Added specific versions for required gems
      *   Fixed VCR cassette problem between Ruby 1.8.7 and 1.9.2 (Run the tests using 1.8.7 first and then 1.9.2 to reuse the same cassette)