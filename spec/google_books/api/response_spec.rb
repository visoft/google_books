require File.dirname(__FILE__) + '/../../spec_helper'

module GoogleBooks
  module API
    describe Response do
      use_vcr_cassette 'google'
      
      it "should set total results" do
        response = API.search('Damien White')
        response.total_results.should > 0
      end
      
      it "should return books" do
        response = API.search('Damien White')
        response.first.should be_a Book
      end
      
    end
  end
end