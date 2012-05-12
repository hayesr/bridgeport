class Area
  include Mongoid::Document
  include Mongoid::Versioning
  
  field :body, type: String
  field :width
  field :label
  field :position, default: 1
  
  embedded_in :page
  
end