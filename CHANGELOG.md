CHANGELOG
=========

v0.0.1
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
