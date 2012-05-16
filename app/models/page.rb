class Page < AbstractDocument
  include Mongoid::Versioning
  # include Mongoid::Tree
  # include Mongoid::Tree::Ordering # => Adds default scope asc(:position)
  include Mongoid::Ancestry
  include Sluggable
  
  has_ancestry
  
  field :title
  field :layout
  field :position
  field :parent_id
  
  embeds_many :regions
  accepts_nested_attributes_for :regions, autosave: true
  
  before_save :clean_title
  
  class << self
    def home_page
      where(title: 'Home').first
    end
    
    def process_positions(params)
      tree = organize_position_params(params)
      position_branches(tree)
    end
    
  end
  
  def sorted_regions
    regions.asc(:position)
  end
  
  def clean_title
    write_attribute :title, title.strip
  end
  
  private
  
  def self.organize_position_params(params)
    tree = {}
    params.each do |k,v|
      if tree[v].nil?
        tree[v] = [k]
      else
        tree[v] << k
      end
    end
    tree
  end
  
  def self.position_branches(tree)
    tree.each do |branch, leaves|
      leaves.each_with_index do |id, i|
        if branch == 'root'
          parent = nil
        else
          parent = branch
        end
        where(_id: id).update_all(parent: parent, position: i)
        #where(_id: id).update(parent: parent, position: i)
        # leaf = find(id)
        # leaf.parent = parent
        # leaf.position = i
        # leaf.save
      end
    end
  end
  
  
end