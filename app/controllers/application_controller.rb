class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def load_root_nav
    @roots = Page.roots.asc(:position)
  end
  
  def edit_mode?
    !!params[:mercury_frame]
  end
  
  helper_method :edit_mode?
  
end
