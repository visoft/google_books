Google Books
============

Google Books is a Ruby wrapper to the [Google Books API](http://code.google.com/apis/books/docs/v1/getting_started.html)
The project was inspired by [google-book](https://github.com/papercavalier/google-book).  It is a nice wrapper, however the [Google Book Search Data API](http://code.google.com/apis/books/docs/gdata/developers_guide_protocol.html) "is deprecated as of May 26, 2011 and will be fully retired on December 1, 2011."

Usage
-----
The usage is similar to that of [google-book](https://github.com/papercavalier/google-book)



Book Attributes
---------------
* **title** - *String*
* **authors** - *Array*
* **publisher** - *String*
* **published\_date** - *Date*
* **isbn** - *String*
* **isbn\_10** - *String*
* **page_count** - *FixNum*
* **categories** - *Array*
* **description** - *String*
* **average\_rating** - *Float*
* **ratings\_count** - *FixNum*
* **covers** - *Hash* - The keys are small\_thumbnail, thumbnail, small, medium, large, extra\_large
* **preview\_link** - *String*
* **info\_link** - *String*