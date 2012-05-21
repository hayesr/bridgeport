module ApplicationHelper
  
  def main_nav(pages, admin_mode = false)
    pages.each do |page|
      content_tag :li do
        link_to page.title, switch_path(page, admin_mode)
      end
    end
  end
  
  def switch_path(resource, admin_mode = false)
    if admin_mode
      path = admin_page_path(resource)
    else
      path = page_path(resource)
    end
    
  end
  
end
