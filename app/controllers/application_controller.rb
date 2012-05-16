class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def load_root_nav
    @roots = Page.roots.asc(:position)
  end
  
end
