module GoogleBooks
  module API
    class Response
      include Enumerable
      
      def initialize(results)
        @results = results
      end
      
      def each(&block)
        @results['items'].each do |item|
          block.call(Book.new(item))
        end
      end
      
      def total_results
        @results['totalItems'].to_i
      end
    end
  end
end