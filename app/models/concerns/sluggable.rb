module Sluggable
  extend ActiveSupport::Concern
  
  included do
    field :slug
    before_save :slugify
  end
  
  module ClassMethods
    def find_by_slug(slug)
      where(:slug => slug).first
    end
    
    def slug_exists?(slug)
      find_by_slug(slug).any?
    end
  end
  
  def slugify
    if self.slug.nil? || self.slug.empty?
      if self.class.slug_exists?(title.parameterize)
        title_slug = title.parameterize + "-1"
      else
        title_slug = title.parameterize
      end
      write_attribute :slug, title_slug
    end
  end
  
end