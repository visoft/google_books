module GoogleBooks
  # A simple wrapper around the Google Books API
  module API
    include HTTParty
    base_uri 'https://www.googleapis.com/books/v1'

    Error = Class.new(StandardError)

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
      #
      # * `:api_key`, your [API key](http://code.google.com/apis/books/docs/v1/using.html#auth) for making requests against the Google Books API.
      def search(query, opts = {})
        self.parameters = { 'q' => query }
        parameters['startIndex'] = opts[:page]  if opts[:page]
        parameters['maxResults'] = opts[:count] if opts[:count]
        parameters['key'] = opts[:api_key] if opts[:api_key]

        Response.new request("/volumes")
      end

      # Query the Google Books API to find a book by its unique VolumeID.
      #
      # The options hash respects the following members:
      #
      # * `:api_key`, your [API key](http://code.google.com/apis/books/docs/v1/using.html#auth) for making requests against the Google Books API.
      def find(id, opts = {})
        self.parameters = {}
        parameters['key'] = opts[:api_key] if opts[:api_key]

        Book.new request("/volumes/#{id}")
      end

      private

      def query
        URI.encode_www_form parameters
      end

      def request(path)
        get(path, { query: query }).tap do |response|
          raise Error, response['error']['message'] if response.has_key?('error')
        end
      end
    end
  end
end