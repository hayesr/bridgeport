class Admin::PagesController < ApplicationController
  
  before_filter :load_root_nav
  
  def index
    # @pages = Page.roots
    @pages = Page.arrange(:order => [:position, :asc])
    render :layout => 'admin'
  end
  
  def show
    @page = Page.find(params[:id])
    # binding.pry
    unless params[:mercury_frame]
      render :layout => 'admin'
    end
  end
  
  def new
    @page = Page.new
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def create
    parse_mercury_create
    
    @page = Page.new(params[:page])
    
    if @page.save
      # redirect_to admin_page_path(@page)
      render text: ""
    else
      render text: "error"
    end
  end
  
  def update
    parse_mercury_update
    
    @page = Page.find(params[:id])
    
    if @page.update_attributes(params[:page])
      # redirect_to admin_page_path(@page)
      render text: ""
    else
      # render action: "edit"
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to admin_pages_path
  end
  
  def sort
    # raise "hi"
    Page.process_positions(params[:page])
    render nothing: true
  end
  
  private
  
  def parse_mercury_update
    if params[:content]
      title = params[:content].delete(:title)
      params[:page] = {:title => title[:value], :regions => []}
      params[:content].each do |k,v|
        params[:page][:regions] << {
          :id => k, :body => v[:value], 
          :position => v[:data][:position].to_i, 
          :width => v[:data][:width], 
          :label => v[:data][:label]
        }
      end
    end  
  end
  
  def parse_mercury_create
    if params[:content]
      title = params[:content].delete(:title)
      params[:page] = {:title => title[:value], :regions => []}
      params[:content].each do |k,v|
        params[:page][:regions] << {
          :body => v[:value], 
          :position => v[:data][:position].to_i, 
          :width => v[:data][:width], 
          :label => v[:data][:label]
        }
      end
    end
    
  end
  
  
end