module Admin::PagesHelper
  def nested_pages(pages)
    # content_tag(:ol, :class => 'page_sorter', :data => { :update_url => sort_admin_pages_path }) do
      pages.map do |page, sub_pages|
        content_tag_for(:li, page) do
          output = rendered_page_item_partial(page)
          if sub_pages.any?
            output << content_tag(:ol, nested_pages(sub_pages))
          end
          output
        end
      end.join.html_safe
    # end
  end
  
  def rendered_page_item_partial(page)
    render( :partial => 'page_item', :locals => { :page => page } )
  end
end