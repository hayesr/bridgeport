class Mercury::Image
  # include Mongoid::Document
  # include Mongoid::Paperclip
  # 
  # has_mongoid_attached_file :image
  # 
  # validates_presence_of :image
  # 
  # delegate :url, :to => :image
  # 
  # def serializable_hash(options = nil)
  #   options ||= {}
  #   options[:methods] ||= []
  #   options[:methods] << :url
  #   super(options)
  # end
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :image_file_name, type: String
  field :image_content_type, type: String
  field :image_file_size, type: String
  field :image_updated_at, type: DateTime

  # CarrierWave
  mount_uploader :image, ImageUploader

  validates_presence_of :image
  
  delegate :url, :to => :image
  
  def serializable_hash(options = nil)
    options ||= {}
    options[:methods] ||= []
    options[:methods] << :url
    super(options)
  end
  
end
