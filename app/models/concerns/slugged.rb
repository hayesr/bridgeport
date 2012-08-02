module Slugged
  extend ActiveSupport::Concern
  
  included do
    field :_slugs, type: Array, default: []
    before_save :save_slug
  end
  
  module ClassMethods
    def find_by_slug(slug)
      doc = where(:_slugs => slug).first
      # raise Mongoid::Errors::DocumentNotFound.new(self, slug) if doc.nil?
    end
    
    def from_param(param)
      if Moped::BSON::ObjectId.legal? param
        find(param)
      else
        find_by_slug(param)
      end
    end
    
    def slug_exists?(slug)
      !find_by_slug(slug).nil?
    end
  end
  
  def to_param
    slug
  end
  
  def slug=(slug_str)
    new_slug = slugify(slug_str)  
    write_attribute :_slugs, ( _slugs | [new_slug] )
  end
  
  def slug
    _slugs.last
  end
  
  def slugify(slug_str)
    if self.class.slug_exists?(slug_str.parameterize)
      new_slug = slug_str.parameterize + "-1"
    else
      new_slug = slug_str.parameterize
    end
    
    unless parent.nil?
      new_slug = self.parent.slug + '/' + new_slug
    end
    
    new_slug
  end
  
  def save_slug
    send(:slug=, title)
  end
  
  
end