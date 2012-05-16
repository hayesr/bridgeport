module Admin::PagesHelper
  def nested_pages(pages)
    content_tag(:ol) do
      pages.map do |page, sub_pages|
        content_tag_for(:li, page) do
          rendered_page_item_partial(page) + content_tag(:ol, nested_pages(sub_pages))
        end
      end.join.html_safe
    end
  end
  
  def rendered_page_item_partial(page)
    render( :partial => 'page_item', :locals => { :page => page } )
  end
end