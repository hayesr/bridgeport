class Tag
  include Mongoid::Document
  has_and_belongs_to_many :abstract_documents
  
  field :name, type: String
  
  validates_uniqueness_of :name
  
  def self.find_by_name(name)
    where(name: name).first
  end
end