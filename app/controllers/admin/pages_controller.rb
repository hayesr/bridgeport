class Admin::PagesController < ApplicationController
  def index
    @pages = Page.all
    
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def create
    @page = Page.new(params[:page])
    
    if @page.save
      redirect_to admin_page_path(@page)
    else
      render action: "new"
    end
  end
  
  def update
    parse_mercury
    
    @page = Page.find(params[:id])
    
    if @page.update_attributes(params[:page])
      # redirect_to admin_page_path(@page)
      render text: ""
    else
      # render action: "edit"
    end
  end
  
  def delete
    
  end
  
  def mercury_update
    page = Page.find(params[:id])
    page.title = params[:content][:page_title][:value]
    page.body = params[:content][:page_body][:value]
    page.save!
    render text: ""
  end
  
  private
  
  def parse_mercury
    if params[:content]
      params[:page] = {:areas => []}
      params[:content].each do |k,v|
        # params[:page][:areas].merge!(k => {:id => k, :body => v[:value], :position => v[:data][:position].to_i})
        params[:page][:areas] << {
          :id => k, :body => v[:value], 
          :position => v[:data][:position].to_i, 
          :width => v[:data][:width], 
          :label => v[:data][:label]
          }
      end
      
      # raise "content"
      # {"content"=>{
      #   "area_0"=>{"type"=>"editable", "value"=>"Area One\n      <div><br></div><div>More.</div>"},
      #   "area_1"=>{"type"=>"editable", "value"=>"Area Two"}
      # }
      # params[:page] = {:areas => {}}
      # params[:content].each do |k,v|
      #   num = k.to_s.split('_')[1]
      #   params[:page][:areas].merge!({"#{num}" => { :body => v[:value] }})
      # end
      
      # params[:page][:title] = params[:content][:area_0][:value]
      # params[:page][:body] = params[:content][:area_1][:value]
      
    end
  end
  
end