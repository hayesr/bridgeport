module Taggable
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :tags
  end
  
  def tag_with(tag_name)
    unless tags.collect(&:name).include?(tag_name)
      pre_existing_tag = Tag.where(name: tag_name).first
      if pre_existing_tag
        tags << pre_existing_tag
      else
        tags << Tag.create(name: tag_name)
      end
    end
  end
  
end