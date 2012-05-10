class Page < AbstractDocument
  include Mongoid::Versioning
  include Sluggable
  
  field :title
  field :layout
  # field :body
  embeds_many :areas
  accepts_nested_attributes_for :areas, autosave: true
  
  # scope :home_page, where(title: 'Home').first
  def self.home_page
    where(title: 'Home').first
  end
  
  def sorted_areas
    areas.sort_by{|a| a.position }
  end
  
  
end