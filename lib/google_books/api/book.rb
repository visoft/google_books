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
        url = @book.imageLinks.first[1]
        {
          :thumbnail => cover_url(url, 5),
          :small => cover_url(url, 1),
          :medium => cover_url(url, 2),
          :large => cover_url(url, 3),
          :extra_large => cover_url(url, 6)                                        
        }
      end

      def titlize(word)
        # From http://snippets.dzone.com/posts/show/294
        non_capitalized = %w{of etc and by the for on is at to but nor or a via}
        word.gsub(/\b[a-z]+/){ |w| non_capitalized.include?(w) ? w : w.capitalize  }.sub(/^[a-z]/){|l| l.upcase }.sub(/\b[a-z][^\s]*?$/){|l| l.capitalize }
      end
      
      def cover_url(url, zoom)
        url.
          gsub(/zoom=\d/, "zoom=#{zoom}").  # Set the zoom level
          gsub(/&edge=curl/, '')            # Who wants the curl on their images
      end
    end
  end
end