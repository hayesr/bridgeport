class PagesController < ApplicationController
  
  before_filter :load_root_nav
  
  def index
    @page = Page.home_page
  end
  
  def show
    if params[:id]
      @page = Page.find(params[:id])
    else
      @page = Page.find_by_slug(params[:slug])
    end
  end
  
end