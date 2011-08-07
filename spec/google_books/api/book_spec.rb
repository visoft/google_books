require File.dirname(__FILE__) + '/../../spec_helper'

module GoogleBooks
  module API
    describe Book do
      use_vcr_cassette 'google'
      
      subject { API.search('isbn:9781935182320').first }
      
      it "should be able to handle a nil object passed" do
        lambda { Book.new(nil) }.should_not raise_error
      end
      
      it "should have a title" do
        subject.title.should eq 'JQuery in Action'
      end
      
      it "should have an array of authors with the correct names" do
        subject.authors.length.should eq 2
        subject.authors[0].should eq "Bear Bibeault"
        subject.authors[1].should eq "Yehuda Katz"
      end
      
      it "should have a publisher" do
        subject.publisher.should_not be_nil
        subject.publisher.should include "Manning"
      end
      
      it "should have a published date in date format" do
        subject.published_date.should be_a Date
        subject.published_date.should eq Date.new(2010, 6, 30)
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
      
      it "should contain a covers hash and keys should be underscored vs camelCased" do
        subject.covers.should be_a Hash
        subject.covers.keys.should_not include 'smallThumbnail'
        subject.covers.keys.should include 'small_thumbnail'
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