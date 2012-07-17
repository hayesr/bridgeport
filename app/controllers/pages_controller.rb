class PagesController < ApplicationController
  
  before_filter :load_root_nav
  
  def index
    @page = Page.home_page
  end
  
  def show
    # raise 'slug'
    # @page = Page.find_by_slug(params[:slug])
    @page = Page.find(params[:id])
  end
end