class PagesController < ApplicationController
  
  before_filter :load_root_nav
  
  def index
    @page = Page.home_page
  end
  
  def show
    @page = Page.find(params[:id])
  end
end