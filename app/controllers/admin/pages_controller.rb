class Admin::PagesController < ApplicationController
  
  before_filter :authenticate_user!  
  before_filter :load_root_nav
  layout :admin_layout
  
  def index
    # @pages = Page.roots
    @pages = Page.arrange(:order => [:position, :asc])
    render :layout => 'admin'
  end
  
  def show
    # raise params[:id].to_s
    @page = Page.from_param(params[:id])
    # raise Mongoid::Errors::DocumentNotFound.new(Page, params) if @page.nil?
    
  end
  
  def new
    @page = Page.new
  end
  
  def create
    parse_mercury_update
    
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
    
    @page = Page.from_param(params[:id])
    
    if @page.update_attributes(params[:page])
      # redirect_to admin_page_path(@page)
      render text: ""
    else
      # render action: "edit"
    end
  end
  
  def destroy
    @page = Page.from_param(params[:id])
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
      params[:page][:slug] = title[:value].parameterize
      params[:content].each do |k,v|        
        unless v[:data][:destroy]
          params[:page][:regions] << {
            :body => v[:value], 
            :position => v[:data][:position].to_i, 
            :width => v[:data][:width], 
            :label => v[:data][:label],
          }
        end
      end
    end  
  end
  
  
  def admin_layout
    params[:mercury_frame] ? 'application' : 'admin'
  end
  
end