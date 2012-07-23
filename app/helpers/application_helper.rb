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
      # path = "#{resource.to_param}"
    end
    
  end
  
  def edit_mode_class
    if edit_mode?
      raw ' class="edit" '
    end
  end
  
end
