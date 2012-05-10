require 'spec_helper'

describe Page do
  # let(:page){ Page.new }
  
  before(:all) do
    Page.delete_all
  end
  
  describe "Slug" do
    it "Takes a title and saves a slug" do
      page = Page.new
      page.title = "This is my page title"
      page.save
      page.slug.should eq "this-is-my-page-title"
    end

    it "Can be found by its slug" do
      my_page = Page.find_by_slug("this-is-my-page-title").first
      my_page.title.should eq "This is my page title"
    end

    it "Should generate unique slugs" do
      page_one = Page.create(title: "About Us")
      page_two = Page.create(title: "About Us")
      
      page_one.slug.should eq ("about-us")
      page_two.slug.should eq ("about-us-1")
    end

    it "Should allow the user to set the slug" do
      page_with_custom_slug = Page.new(title: "This is my title", slug: "this-is-my-slug")
      page_with_custom_slug.save
      page_with_custom_slug.reload
      page_with_custom_slug.slug.should eq "this-is-my-slug"
    end
  end
  
  
  

end