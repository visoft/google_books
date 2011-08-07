module GoogleBooks
  module API
    class Book
      attr_reader :title, :authors, :publisher, :published_date,
                  :isbn, :isbn_10, :page_count, :categories,
                  :description, :average_rating, :ratings_count,
                  :covers, :preview_link, :info_link
      
      def initialize(item)
        return if item.nil?
        parse_item(item)
      end
      
      private
      
      def parse_item(item)
        volume_info = item['volumeInfo']
        @book = Hashie::Mash.new volume_info
        if @book.subtitle.nil?
          @title = @book.title
        else
          @title = "#{@book.title}: #{titlize(@book.subtitle)}"
        end
        @authors = @book.authors || []
        @publisher = @book.publisher
        @published_date = @book.publishedDate
        @description = @book.description
        @isbn = get_isbn_for_book
        @isbn_10 = get_isbn_for_book(10)
        @page_count = @book.pageCount
        @categories = @book.categories
        @average_rating = @book.averageRating
        @ratings_count = @book.ratingsCount
        @covers = fixup_covers
        @preview_link = @book.previewLink
        @info_link = @book.infoLink
      end
      
      def get_isbn_for_book(type=13)
        return nil if @book.industryIdentifiers.nil?
        isbn = @book.industryIdentifiers.find { |id| id.type == "ISBN_#{type}" }
        return nil if isbn.nil?
        isbn.identifier
      end
      
      def fixup_covers
        return {} if @book.imageLinks.nil?
        @book.imageLinks.inject({}) { |x, (k,v)| x[underscore(k).to_sym] = clean_cover_url(v); x }
      end
      
      def underscore(camel_cased_word)
        # Snagged from the ActiveSupport Inflector method underscore
        # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-underscore
        # Didn't want to include ActiveSupport for just this method
        word = camel_cased_word.to_s.dup
        word.gsub!(/::/, '/')
        word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        word.tr!("-", "_")
        word.downcase!
        word
      end
      
      def titlize(word)
        # From http://snippets.dzone.com/posts/show/294
        non_capitalized = %w{of etc and by the for on is at to but nor or a via}
        word.gsub(/\b[a-z]+/){ |w| non_capitalized.include?(w) ? w : w.capitalize  }.sub(/^[a-z]/){|l| l.upcase }.sub(/\b[a-z][^\s]*?$/){|l| l.capitalize }
      end
      
      def clean_cover_url(url)
        url.gsub('&edge=curl', '') # Who wants the curl on their images
      end
    end
  end
end