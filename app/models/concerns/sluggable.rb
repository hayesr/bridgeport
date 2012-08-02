module Sluggable
  extend ActiveSupport::Concern
  
  included do
    field :_slugs, type: Array, default: []
    field :slug
    before_save :slugify
  end
  
  module ClassMethods
    def find_by_slug(slug)
      doc = where(:slug => slug).first
      # raise Mongoid::Errors::DocumentNotFound.new(self, slug) if doc.nil?
    end
    
    def slug_exists?(slug)
      !find_by_slug(slug).nil?
    end
  end
  
  def slugify
    
    if self.slug.nil? || self.slug.empty?
      if self.class.slug_exists?(title.parameterize)
        title_slug = title.parameterize + "-1"
      else
        title_slug = title.parameterize
      end
      
      unless parent.nil?
        title_slug = self.parent.slug + '/' + title_slug
      end
      
      write_attribute :slug, title_slug
      new_slug = title_slug
    end
  end
  
  def new_slug=(slug)
    slugified_slug = slugify(slug)
    write_attribute :_slugs, ( _slugs | [slugified_slug] )
  end
  
end