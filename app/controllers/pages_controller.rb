class PagesController < ApplicationController
  def index
    @page = Page.home_page
  end
  
  def show
    
  end
end