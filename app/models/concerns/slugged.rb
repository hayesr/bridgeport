module Slugged
  extend ActiveSupport::Concern
  include ActiveSupport::Inflector
  
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
    new_slug = build_slug(slug_str)  
    write_attribute :_slugs, ( _slugs | [new_slug] ).compact
  end
  
  def slug
    _slugs.last
  end
  
  def build_slug(slug_str)
    
    new_slug = slugify(slug_str)

    unless _slugs.include? new_slug
      if self.class.slug_exists?(new_slug)
        new_slug << "-1"
      end
    end
    
    unless parent.nil? || _slugs.include?(self.parent.slug + '/' + new_slug)
      new_slug = self.parent.slug + '/' + new_slug
    end
    
    new_slug
    
  end
  
  def save_slug
    send(:slug=, title)
  end
  
  
  def slugify(str, sep = '-')
    # replace accented chars with their ascii equivalents
    parameterized_string = transliterate(str)
    # Turn unwanted chars into the separator
    parameterized_string.gsub!(/[^a-z0-9\-\/_]+/i, sep)
    parameterized_string.gsub!(/[^a-z0-9\-_]+/i, sep)
    unless sep.nil? || sep.empty?
      re_sep = Regexp.escape(sep)
      # No more than one of the separator in a row.
      parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
      # Remove leading/trailing separator.
      parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/i, '')
    end
    parameterized_string.downcase
  end
  
  # def parameterize(string, sep = '-')
  #   # replace accented chars with their ascii equivalents
  #   parameterized_string = transliterate(string)
  #   # Turn unwanted chars into the separator
  #   parameterized_string.gsub!(/[^a-z0-9\-_]+/i, sep)
  #   unless sep.nil? || sep.empty?
  #     re_sep = Regexp.escape(sep)
  #     # No more than one of the separator in a row.
  #     parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
  #     # Remove leading/trailing separator.
  #     parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/i, '')
  #   end
  #   parameterized_string.downcase
  # end
end

# On creation save slug
# If the title changes, save a new slug
# If the slug already exists, modify it
# If the page is repositioned, modify the slug
