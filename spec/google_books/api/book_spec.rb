require File.dirname(__FILE__) + '/../../spec_helper'

module GoogleBooks
  module API
    describe Book do
      use_vcr_cassette 'google'
      
      subject { API.search('isbn:9781935182320').first }
      
      let(:item) do
        item = { 'volumeInfo' => {} }
      end
      
      it "should be able to handle a nil object passed" do
        lambda { Book.new(nil) }.should_not raise_error
      end
      
      it "should have a title" do
        subject.title.should eq 'JQuery in Action'
      end
      
      it "should contain a subtitle in the title if there is one" do
        book = API.search('isbn:9780596517748').first
        book.title.should eq 'JavaScript: The Good Parts'
      end
      
      it "should have an array of authors with the correct names" do
        subject.authors.length.should eq 2
        subject.authors[0].should eq "Bear Bibeault"
        subject.authors[1].should eq "Yehuda Katz"
      end
      
      describe "publisher" do
        it "should have a publisher" do
          subject.publisher.should_not be_nil
          subject.publisher.should include "Manning"
        end
        
        it "should standardize an Inc to Inc." do
          item['volumeInfo']['publisher'] = "Publisher Inc"
          book = Book.new(item)
          book.publisher.should eq "Publisher Inc."
        end
        
        it "should standardize an Llc to LLC." do
          item['volumeInfo']['publisher'] = "Publisher Llc"
          book = Book.new(item)
          book.publisher.should eq "Publisher LLC."
        end
        
        it "should standardize an Ltd to Ltd." do
          item['volumeInfo']['publisher'] = "Publisher Ltd"
          book = Book.new(item)
          book.publisher.should eq "Publisher Ltd."
        end
        
        it "should replace Intl with International anywhere in the name" do
          item['volumeInfo']['publisher'] = "Publisher Intl Clearing House"
          book = Book.new(item)
          book.publisher.should eq "Publisher International Clearing House"
        end
        
        it "should replace Pr with Press anywhere in the name" do
          item['volumeInfo']['publisher'] = "Publisher Pr House"
          book = Book.new(item)
          book.publisher.should eq "Publisher Press House"
        end
        
        it "should replace Pub with Publishers anywhere in the name" do
          item['volumeInfo']['publisher'] = "Publisher Pub, Inc"
          book = Book.new(item)
          book.publisher.should eq "Publisher Publishers Inc."
        end
        
        it "should replace Pubns with Publications anywhere in the name" do
          item['volumeInfo']['publisher'] = "Publisher Pubns Inc"
          book = Book.new(item)
          book.publisher.should eq "Publisher Publications Inc."
        end
        
        it "should replace Pub Group with Publishing Group anywhere in the name" do
          item['volumeInfo']['publisher'] = "Publisher Pub Group Inc"
          book = Book.new(item)
          book.publisher.should eq "Publisher Publishing Group Inc."
        end
        
        it "should replace Univ with University anywhere in the name" do
          item['volumeInfo']['publisher'] = "Publisher Univ Pr"
          book = Book.new(item)
          book.publisher.should eq "Publisher University Press"
        end
        
        it "should handle strings with apostrophes" do
          item['volumeInfo']['publisher'] = "O'Reilly Media, Inc."
          book = Book.new(item)
          book.publisher.should eq "O'Reilly Media Inc."
        end
      end
      
      describe "published_date" do
        it "should have a published date in sting format" do
          subject.published_date.should eq "2010-06-30"
        end

        it "should handle a published date that is only a year" do
          book = API.search('isbn:9781934356166').first
          book.published_date.should eq "2009"
        end

        it "should handle a published date that is only a month and a year" do
          book = API.search('isbn:9780954344405').first
          book.published_date.should eq "2003-01"
        end        
      end
      
      it "should have description (which may be blank)" do
        subject.description.should_not be_nil
      end
      
      it "should have an ISBN (13)" do
        subject.isbn.should eq '9781935182320'
      end
      
      it "should have an ISBN 10" do
        subject.isbn_10.should eq '1935182323'
      end
      
      it "should have a page count" do
        subject.page_count.should be_a Fixnum
        subject.page_count.should eq 475
      end
      
      it "should have categories" do
        subject.categories.should be_an Array
        subject.categories.first.should eq "Computers"
      end
      
      it "should have an average rating" do
        subject.average_rating.should be_a Float
      end
      
      it "should have an ratings count" do
        subject.ratings_count.should be_a Fixnum
      end
      
      describe "covers" do
        it "should contain a covers hash" do
          subject.covers.should be_a Hash
          subject.covers.keys.should include :thumbnail
          subject.covers.keys.should include :small
          subject.covers.keys.should include :medium
          subject.covers.keys.should include :large
          subject.covers.keys.should include :extra_large        
        end

        it "should not have curls on the cover urls" do
          subject.covers[:thumbnail].should_not include 'edge=curl'
          subject.covers[:small].should_not include 'edge=curl'
          subject.covers[:medium].should_not include 'edge=curl'
          subject.covers[:large].should_not include 'edge=curl'
          subject.covers[:extra_large].should_not include 'edge=curl'
        end

        it "should have the cover url zoom level" do
          subject.covers[:thumbnail].should include 'zoom=5'
          subject.covers[:small].should include 'zoom=1'
          subject.covers[:medium].should include 'zoom=2'
          subject.covers[:large].should include 'zoom=3'
          subject.covers[:extra_large].should include 'zoom=6'
        end
      end
      
      it "should contains a preview link" do
        subject.preview_link.should_not be_nil
      end
      
      it "should contains an info link" do
        subject.info_link.should_not be_nil
      end
    end
  end
end