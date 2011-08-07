module GoogleBooks
  module API
    class Response
      include Enumerable
      
      def initialize(results)
        @results = results
      end
      
      # Iterator for looping through the results
      def each(&block)
        @results['items'].each do |item|
          block.call(Book.new(item))
        end
      end
      
      # The total number of results that were found for your query (not the count of the results returned)
      def total_results
        @results['totalItems'].to_i
      end
    end
  end
end