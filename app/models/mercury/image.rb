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
  field :image_dimensions, type: Array

  # CarrierWave
  mount_uploader :image, ImageUploader
  validates_presence_of :image
  delegate :url, :to => :image
  before_create :save_file_name, :save_size, :save_dimensions
  
  def serializable_hash(options = nil)
    options ||= {}
    options[:methods] ||= []
    options[:methods] << :url
    super(options)
  end
  
  def save_file_name
    write_attribute :image_file_name, File.basename(file_path)
  end
  
  def save_size
    write_attribute :image_file_size, File.size(file_path)
  end
  
  def save_dimensions
    write_attribute :image_dimensions, [rmagick_file.columns.to_i,rmagick_file.rows.to_i]
  end
  
  def rmagick_file
    Magick::Image::read(file_path).first
  end
  
  def file_path
    Rails.root.to_s + '/public' +  image_url
  end
  
  def width
    image_dimensions[0]
  end
  
  def height
    image_dimensions[1]
  end
  
end
