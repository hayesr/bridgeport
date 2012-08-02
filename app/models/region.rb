class Region
  include Mongoid::Document
  # include Mongoid::Versioning
  
  field :body, type: String
  field :width
  field :label
  field :position, default: 1
  
  embedded_in :page
  
  def to_html
    # Liquid::Template.parse(body).render
  end
  
  def body_with_links
    body.gsub(/(.?)\[\[(.+?)\]\]([^\[]?)/m) do
      if $2.include?('|')
        parts = $2.split('|')
        slug = parts[1].parameterize('/')
        text = parts[0].titleize
      else
        slug = $2.parameterize
        text = $2.humanize
      end
      if Page.page_exists?(slug)
        presence = "present"
      else
        presence = 'absent'
      end
      link = "<a href=\"/#{slug}\" class=\"#{presence}\">#{text}</a>"
      "#{$1}#{link}#{$3}"
    end
  end
  
end