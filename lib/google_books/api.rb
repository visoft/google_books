module GoogleBooks
  # A simple wrapper around the Google Books API
  module API
    include HTTParty
    class << self

      # The search parameters.
      attr_accessor :parameters      
      
      # Queries the Google Books API. Takes a query string and an
      # optional options hash.
      #
      # The options hash respects the following members:
      #
      # * `:page`, which specifies the page.
      #
      # * `:count`, which specifies the number of results per page.
      def search(query, opts ={})
        self.parameters = { 'q' => query }
        parameters['startIndex'] = opts[:page]  if opts[:page]
        parameters['maxResults'] = opts[:count] if opts[:count]
        
        result = get(url.to_s)
        Response.new result
      end
      
      private
      
      def query
        parameters.
          map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.
          join('&')
      end
      
      def url
        URI::HTTPS.build(:host  => 'www.googleapis.com',
                         :path  => '/books/v1/volumes',
                         :query => query)
      end
    end
  end
end