class MercuryController < ActionController::Base
  # include ::Mercury::Authentication
  include ::Oxygen::Authorization

  protect_from_forgery
  before_filter :authenticate, :only => :edit
  layout false

  def edit
    render :text => '', :layout => 'mercury'
  end

  def resource
    render :action => "/#{params[:type]}/#{params[:resource]}"
  end

  def snippet_options
    @options = params[:options] || {}
    render :action => "/snippets/#{params[:name]}/options"
  end

  def snippet_preview
    render :action => "/snippets/#{params[:name]}/preview"
  end

  def test_page
    render :text => params
  end

  private

  def authenticate
    redirect_to "/#{params[:requested_uri]}", notice: "Sorry you can't edit that." unless can?(:edit, record)
  end
  
  # def record
  #   record_id = request.path.split('/').last
  #   klass = request.path.split('/')[-2].singularize.capitalize.constantize
  #   if record_id == 'new'
  #     record = klass.new
  #   else
  #     record = klass.from_param(record_id)
  #   end
  # end
  def record
    record_id = request.path.split('/').last
    # klass = request.path.split('/')[-2].singularize.capitalize.constantize
    if record_id == 'new'
      record = Page.new
    else
      record = Page.from_param(record_id)
    end
  end
  
  
end