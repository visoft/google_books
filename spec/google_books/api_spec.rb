require File.dirname(__FILE__) + '/../spec_helper'
  
module GoogleBooks
  describe API do
    use_vcr_cassette 'google'
    
    describe "search" do
      it "should escape spaces" do
        API.search('damien white')
        API.send(:query).should include 'q=damien+white'
      end
      
      it "should set the page" do
        API.search('damien white', :page => 2)
        API.send(:query).should include 'startIndex=2'
      end

      it "should set the number of results per page" do
        API.search('damien white', :count => 20)
        API.send(:query).should include 'maxResults=20'
      end
      
      it "should accept in an API key" do
        API.search('damien white', :api_key => 'ABCDEFG')
        API.send(:query).should include 'key=ABCDEFG'
      end
      
      it "should join parameters" do
        API.search('damien white', :count => 20, :page => 2)
        API.send(:query).should include 'startIndex=2&maxResults=20'
      end
      
      it "should return the proper number results based on the count passed in" do
        results = API.search('damien white', :count => 20)
        results.count.should eq 20
      end
      
      it "should return a response" do
        API.search('damien white').should be_a API::Response
      end
      
    end
  end
end