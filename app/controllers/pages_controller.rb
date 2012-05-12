class PagesController < ApplicationController
  def index
    @page = Page.home_page
  end
  
  def show
    @page = Page.find(params[:id])
  end
end