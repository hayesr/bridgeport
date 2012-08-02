require 'spec_helper'

describe Page do
  # let(:page){ Page.new }
  
  before(:all) do
    Page.delete_all
    @page = Page.new
  end
  
  describe "Slug" do
    it "Takes a title and saves a slug" do
      @page.title = "This is my page title"
      @page.save
      @page.slug.should eq "this-is-my-page-title"
    end

    it "Can be found by its slug" do
      my_page = Page.from_param("this-is-my-page-title")
      my_page.title.should eq "This is my page title"
    end

    it "Should generate unique slugs" do
      page_one = Page.create(title: "About Us")
      page_two = Page.create(title: "About Us")
      
      page_one.slug.should eq ("about-us")
      page_two.slug.should eq ("about-us-1")
    end

    # it "Should allow the user to set the slug" do
    #   page_with_custom_slug = Page.new(title: "This is my title", slug: "this-is-my-slug")
    #   page_with_custom_slug.save
    #   page_with_custom_slug.reload
    #   page_with_custom_slug.slug.should eq "this-is-my-slug"
    # end
    
    it "Should save a new slug when the title changes" do
      @page.title = 'This is my new title'
      @page.save
      @page._slugs.count.should > 1
      @page.slug.should eq 'this-is-my-new-title'
    end
    
    it "Should set a nested slug based on parent" do
      parent_page = Page.create(title: "Parent Page")
      nested_page = Page.create(title: "Nested Page", parent: parent_page)
      
      nested_page.is_root?.should_not be true
      nested_page.slug.should eq "parent-page/nested-page"
    end
    
    it "Should remember old slugs" do
      multi_slug = Page.create(title: 'Multi Slug')
      multi_slug._slugs.should eq ['multi-slug']
      multi_slug.slug = "New Slug"
      multi_slug._slugs.should eq ['multi-slug', 'new-slug']
    end
    
    it "Should be found using old as well as new slugs" do
      old_slug = Page.from_param("this-is-my-page-title")
      new_slug = Page.from_param("this-is-my-new-title")
      
      old_slug.title.should eq new_slug.title
    end
  end
  
  
  

end